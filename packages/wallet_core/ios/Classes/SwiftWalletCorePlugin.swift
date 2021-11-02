import Flutter
import UIKit

public class SwiftWalletCorePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "wallet_core", binaryMessenger: registrar.messenger())
        let instance = SwiftWalletCorePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    private let walletManager = WalletManager()
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        walletManager.callData =  call.arguments as! [Any]
        if let safeMethod = CallMethod.init(rawValue: call.method) {
            switch safeMethod {
            case .genNewWallet:
                walletManager.genNewWallet()
            case .importNewWalletByMnemonic:
                walletManager.importNewWalletByMnemonic()
            case .importNewWalletByPrivateKey:
                walletManager.importNewWalletByPrivateKey()
            }
        }
        result(walletManager.resultData)
    }
}

public enum CallMethod: String {
    case genNewWallet = "genNewWallet"
    case importNewWalletByMnemonic = "importNewWalletByMnemonic"
    case importNewWalletByPrivateKey = "importNewWalletByPrivateKey"
}

