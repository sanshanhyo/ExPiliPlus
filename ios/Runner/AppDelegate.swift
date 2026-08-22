import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var gifExportChannel: FlutterMethodChannel?
  private var gifExportSession: GifExportSession?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    application.applicationSupportsShakeToEdit = false // Disable shake to undo
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(
      name: "io.github.sanshanhyo.expiliplus/gif_export",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
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
}

private extension GifExportError {
  var flutterError: FlutterError {
    switch self {
    case .invalidArguments:
      return FlutterError(code: "invalid_arguments", message: "Invalid GIF export arguments.", details: nil)
    case .cancelled:
      return FlutterError(code: "cancelled", message: "GIF export was cancelled.", details: nil)
    case .assetUnreadable(let details):
      return FlutterError(code: "asset_unreadable", message: "The video source cannot be read by iOS.", details: details)
    case .outputCreation:
      return FlutterError(code: "output_creation_failed", message: "The GIF output could not be created.", details: nil)
    case .frameGeneration(let message):
      return FlutterError(code: "frame_generation_failed", message: message, details: nil)
    case .outputFinalize:
      return FlutterError(code: "output_finalize_failed", message: "The GIF output could not be finalized.", details: nil)
    }
  }
}
