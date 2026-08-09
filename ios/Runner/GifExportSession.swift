import AVFoundation
import ImageIO
import UniformTypeIdentifiers

final class GifExportSession {
  private let arguments: [String: Any]
  private let cancellationLock = NSLock()
  private var isCancelled = false

  init(arguments: [String: Any]) {
    self.arguments = arguments
  }

  func cancel() {
    cancellationLock.lock()
    isCancelled = true
    cancellationLock.unlock()
  }

  func generate(
    onProgress: @escaping (Double) -> Void,
    completion: @escaping (Result<String, GifExportError>) -> Void
  ) {
    DispatchQueue.global(qos: .userInitiated).async { [self] in
      do {
        let request = try GifExportRequest(arguments: arguments)
        let outputPath = try render(request, onProgress: onProgress)
        completion(.success(outputPath))
      } catch let error as GifExportError {
        completion(.failure(error))
      } catch {
        completion(.failure(.frameGeneration(error.localizedDescription)))
      }
    }
  }

  private func render(
    _ request: GifExportRequest,
    onProgress: @escaping (Double) -> Void
  ) throws -> String {
    let outputURL = URL(fileURLWithPath: request.outputPath)
    let fileManager = FileManager.default
    try fileManager.createDirectory(
      at: outputURL.deletingLastPathComponent(),
      withIntermediateDirectories: true
    )
    if fileManager.fileExists(atPath: outputURL.path) {
      try fileManager.removeItem(at: outputURL)
    }

    let asset = AVURLAsset(
      url: request.sourceURL,
      options: [
        "AVURLAssetHTTPHeaderFieldsKey": [
          "User-Agent": request.userAgent,
          "Referer": request.referer,
        ],
        AVURLAssetPreferPreciseDurationAndTimingKey: true,
      ]
    )
    guard let videoTrack = asset.tracks(withMediaType: .video).first else {
      throw GifExportError.assetUnreadable
    }

    let transformedSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
    let sourceWidth = abs(transformedSize.width)
    let sourceHeight = abs(transformedSize.height)
    guard sourceWidth > 0, sourceHeight > 0 else {
      throw GifExportError.assetUnreadable
    }
    let targetWidth = request.width
    let targetHeight = max(1, Int((Double(targetWidth) * Double(sourceHeight / sourceWidth)).rounded()))

    let frameCount = max(1, Int((request.duration * Double(request.fps)).rounded(.down)))
    guard let destination = CGImageDestinationCreateWithURL(
      outputURL as CFURL,
      UTType.gif.identifier as CFString,
      frameCount,
      nil
    ) else {
      throw GifExportError.outputCreation
    }
    CGImageDestinationSetProperties(
      destination,
      [
        kCGImagePropertyGIFDictionary: [
          kCGImagePropertyGIFLoopCount: 0,
        ],
      ] as CFDictionary
    )

    let frameDelay = 1.0 / Double(request.fps)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    let frameTolerance = CMTime(
      seconds: frameDelay / 2,
      preferredTimescale: 60_000
    )
    generator.requestedTimeToleranceBefore = frameTolerance
    generator.requestedTimeToleranceAfter = frameTolerance
    generator.maximumSize = CGSize(width: targetWidth, height: targetHeight)

    let frameProperties = [
      kCGImagePropertyGIFDictionary: [
        kCGImagePropertyGIFDelayTime: frameDelay,
        kCGImagePropertyGIFUnclampedDelayTime: frameDelay,
      ],
    ] as CFDictionary

    do {
      for index in 0..<frameCount {
        try checkCancellation()
        let seconds = request.start + (Double(index) / Double(request.fps))
        let time = CMTime(seconds: seconds, preferredTimescale: 60_000)
        let image = try autoreleasepool {
          let source = try generator.copyCGImage(at: time, actualTime: nil)
          return try resized(source, width: targetWidth, height: targetHeight)
        }
        CGImageDestinationAddImage(destination, image, frameProperties)
        onProgress(Double(index + 1) / Double(frameCount))
      }
      try checkCancellation()
      guard CGImageDestinationFinalize(destination) else {
        throw GifExportError.outputFinalize
      }
      return outputURL.path
    } catch {
      try? fileManager.removeItem(at: outputURL)
      throw error
    }
  }

  private func checkCancellation() throws {
    cancellationLock.lock()
    let cancelled = isCancelled
    cancellationLock.unlock()
    if cancelled { throw GifExportError.cancelled }
  }

  private func resized(_ image: CGImage, width: Int, height: Int) throws -> CGImage {
    if image.width == width, image.height == height { return image }
    guard let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: 8,
      bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
      throw GifExportError.frameGeneration("Unable to allocate the GIF frame buffer.")
    }
    context.interpolationQuality = .high
    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
    guard let result = context.makeImage() else {
      throw GifExportError.frameGeneration("Unable to resize a GIF frame.")
    }
    return result
  }
}

private struct GifExportRequest {
  let sourceURL: URL
  let outputPath: String
  let start: Double
  let duration: Double
  let width: Int
  let fps: Int
  let userAgent: String
  let referer: String

  init(arguments: [String: Any]) throws {
    guard
      let urlString = arguments["url"] as? String,
      let sourceURL = URL(string: urlString),
      let outputPath = arguments["outputPath"] as? String,
      let start = arguments["start"] as? Double,
      let duration = arguments["duration"] as? Double,
      let width = arguments["width"] as? Int,
      let fps = arguments["fps"] as? Int,
      let userAgent = arguments["userAgent"] as? String,
      let referer = arguments["referer"] as? String,
      sourceURL.isFileURL || sourceURL.scheme == "https" || sourceURL.scheme == "http",
      !outputPath.isEmpty,
      start >= 0,
      duration > 0,
      duration <= 10,
      width > 0,
      width <= 720,
      fps > 0,
      fps <= 15
    else {
      throw GifExportError.invalidArguments
    }
    self.sourceURL = sourceURL
    self.outputPath = outputPath
    self.start = start
    self.duration = duration
    self.width = width
    self.fps = fps
    self.userAgent = userAgent
    self.referer = referer
  }
}

enum GifExportError: Error {
  case invalidArguments
  case cancelled
  case assetUnreadable
  case outputCreation
  case frameGeneration(String)
  case outputFinalize
}
