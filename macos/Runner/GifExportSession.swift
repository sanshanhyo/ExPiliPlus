import AVFoundation
import Foundation
import ImageIO

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
        diagnostic(
          "start duration=\(request.duration) width=\(request.width) fps=\(request.fps)"
        )
        let outputPath = try render(request, onProgress: onProgress)
        diagnostic("end success outputBytes=\(fileSize(atPath: outputPath))")
        completion(.success(outputPath))
      } catch let error as GifExportError {
        diagnostic("end error=\(error.diagnosticDescription)")
        completion(.failure(error))
      } catch {
        let nsError = error as NSError
        diagnostic("end errorDomain=\(nsError.domain) errorCode=\(nsError.code)")
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
    do {
      try fileManager.createDirectory(
        at: outputURL.deletingLastPathComponent(),
        withIntermediateDirectories: true
      )
      if fileManager.fileExists(atPath: outputURL.path) {
        try fileManager.removeItem(at: outputURL)
      }
    } catch {
      throw GifExportError.outputCreation
    }
    diagnostic("output-created pathExtension=\(outputURL.pathExtension)")

    do {
      try checkCancellation()
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
      diagnostic("asset-created")
      guard let videoTrack = try loadVideoTracks(asset).first else {
        throw GifExportError.assetUnreadable("No video track was loaded.")
      }
      diagnostic("video-track-loaded")

      let transformedSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
      let sourceWidth = abs(transformedSize.width)
      let sourceHeight = abs(transformedSize.height)
      guard sourceWidth > 0, sourceHeight > 0 else {
        throw GifExportError.assetUnreadable("Video track has no usable dimensions.")
      }
      let targetWidth = request.width
      let targetHeight = max(1, Int((Double(targetWidth) * Double(sourceHeight / sourceWidth)).rounded()))

      let frameCount = max(1, Int((request.duration * Double(request.fps)).rounded(.down)))
      diagnostic("frame-plan count=\(frameCount) target=\(targetWidth)x\(targetHeight)")
      guard let destination = CGImageDestinationCreateWithURL(
        outputURL as CFURL,
        "com.compuserve.gif" as CFString,
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
        if index == 0 || index + 1 == frameCount || (index + 1) % max(1, request.fps) == 0 {
          diagnostic("frame-progress index=\(index + 1) total=\(frameCount)")
        }
      }
      try checkCancellation()
      guard CGImageDestinationFinalize(destination) else {
        throw GifExportError.outputFinalize
      }
      diagnostic("finalize success")
      return outputURL.path
    } catch {
      try? fileManager.removeItem(at: outputURL)
      throw error
    }
  }

  private func loadVideoTracks(_ asset: AVAsset) throws -> [AVAssetTrack] {
    let semaphore = DispatchSemaphore(value: 0)
    asset.loadValuesAsynchronously(forKeys: ["tracks"]) {
      semaphore.signal()
    }
    guard semaphore.wait(timeout: .now() + 60) == .success else {
      diagnostic("video-track-load-timeout")
      throw GifExportError.assetUnreadable("Timed out while loading video tracks.")
    }

    var loadError: NSError?
    let status = asset.statusOfValue(forKey: "tracks", error: &loadError)
    guard status == .loaded else {
      if let loadError {
        diagnostic(
          "video-track-load-failed domain=\(loadError.domain) code=\(loadError.code)"
        )
        throw GifExportError.assetUnreadable(
          "Video tracks failed to load (\(loadError.domain), \(loadError.code))."
        )
      }
      diagnostic("video-track-load-failed status=\(status.rawValue)")
      throw GifExportError.assetUnreadable(
        "Video tracks failed to load (status \(status.rawValue))."
      )
    }
    return asset.tracks(withMediaType: .video)
  }

  private func diagnostic(_ message: String) {
    NSLog("GifExport: %@", message)
  }

  private func fileSize(atPath path: String) -> UInt64 {
    let attributes = try? FileManager.default.attributesOfItem(atPath: path)
    return (attributes?[.size] as? NSNumber)?.uint64Value ?? 0
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
  case assetUnreadable(String)
  case outputCreation
  case frameGeneration(String)
  case outputFinalize

  var diagnosticDescription: String {
    switch self {
    case .invalidArguments:
      return "invalid_arguments"
    case .cancelled:
      return "cancelled"
    case .assetUnreadable(let message):
      return "asset_unreadable message=\(message)"
    case .outputCreation:
      return "output_creation_failed"
    case .frameGeneration(let message):
      return "frame_generation_failed message=\(message)"
    case .outputFinalize:
      return "output_finalize_failed"
    }
  }
}
