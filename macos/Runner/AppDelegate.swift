import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  private var gifExportChannel: FlutterMethodChannel?
  private var gifExportSession: GifExportSession?

  func registerGifExport(with flutterViewController: FlutterViewController) {
    guard gifExportChannel == nil else { return }
    let channel = FlutterMethodChannel(
      name: "io.github.sanshanhyo.expiliplus/gif_export",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    gifExportChannel = channel
    channel.setMethodCallHandler { [weak self] call, result in
      self?.handleGifExport(call, result: result)
    }
  }

  private func handleGifExport(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "generate":
      guard gifExportSession == nil else {
        result(FlutterError(code: "busy", message: "A GIF export is already running.", details: nil))
        return
      }
      guard let arguments = call.arguments as? [String: Any] else {
        result(FlutterError(code: "invalid_arguments", message: "Missing GIF export arguments.", details: nil))
        return
      }
      let session = GifExportSession(arguments: arguments)
      gifExportSession = session
      session.generate(
        onProgress: { [weak self] progress in
          DispatchQueue.main.async {
            self?.gifExportChannel?.invokeMethod("progress", arguments: progress)
          }
        },
        completion: { [weak self] exportResult in
          DispatchQueue.main.async {
            self?.gifExportSession = nil
            switch exportResult {
            case .success(let outputPath):
              result(outputPath)
            case .failure(let error):
              result(error.flutterError)
            }
          }
        }
      )
    case "cancel":
      gifExportSession?.cancel()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return false
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    if !flag {
      for window in NSApp.windows {
        if !window.isVisible {
          window.setIsVisible(true)
        }
        window.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
      }
    }
    return true
  }
}

private extension GifExportError {
  var flutterError: FlutterError {
    switch self {
    case .invalidArguments:
      return FlutterError(code: "invalid_arguments", message: "Invalid GIF export arguments.", details: nil)
    case .cancelled:
      return FlutterError(code: "cancelled", message: "GIF export was cancelled.", details: nil)
    case .assetUnreadable(let details):
      return FlutterError(code: "asset_unreadable", message: "The video source cannot be read by macOS.", details: details)
    case .outputCreation:
      return FlutterError(code: "output_creation_failed", message: "The GIF output could not be created.", details: nil)
    case .frameGeneration(let message):
      return FlutterError(code: "frame_generation_failed", message: message, details: nil)
    case .outputFinalize:
      return FlutterError(code: "output_finalize_failed", message: "The GIF output could not be finalized.", details: nil)
    }
  }
}
