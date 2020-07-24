import Flutter
import UIKit
import AdSupport

public class SwiftTxDeviceIdPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tx_device_id", binaryMessenger: registrar.messenger())
    let instance = SwiftTxDeviceIdPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  //   result("iOS " + UIDevice.current.systemVersion)
  // }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getPlatformVersion":
          result("iOS " + UIDevice.current.systemVersion)
      case "getIDFA":
          var idfaString: String!
          let manager = ASIdentifierManager.shared()
          if manager.isAdvertisingTrackingEnabled {
              idfaString = manager.advertisingIdentifier.uuidString
          } else {
              idfaString = ""
          }
          result(idfaString)
      default:
          result(nil)
    }
  }
}
