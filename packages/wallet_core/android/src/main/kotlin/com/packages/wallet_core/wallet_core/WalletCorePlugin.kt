package com.packages.wallet_core.wallet_core

import androidx.annotation.NonNull
import com.google.protobuf.Any

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WalletCorePlugin */
class WalletCorePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val walletManager: WalletManager = WalletManager()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wallet_core")
    channel.setMethodCallHandler(this)
  }
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    walletManager.callData = call.arguments as List<Any>
    when (call.method) {
      Method.GENNEW.method -> walletManager.genNewWallet()
      Method.IMPORTMNEMONIC.method -> walletManager.importNewWalletByMnemonic()
      Method.IMPORTPRIVATEKEY.method -> walletManager.importNewWalletByPrivateKey()
      else -> result.notImplemented()
    }
    result.success(walletManager.resultData)
  }
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

private enum class Method(val method:String) {
  GENNEW("genNewWallet"),
  IMPORTMNEMONIC("importNewWalletByMnemonic"),
  IMPORTPRIVATEKEY("importNewWalletByPrivateKey"),
}


