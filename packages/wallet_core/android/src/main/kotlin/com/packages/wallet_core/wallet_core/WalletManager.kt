package com.packages.wallet_core.wallet_core
import kotlin.experimental.and

import wallet.core.jni.CoinType
import wallet.core.jni.HDWallet
import  wallet.core.jni.PrivateKey
import java.security.InvalidParameterException

class WalletManager {
    init {
        System.loadLibrary("TrustWalletCore")
    }

    var callData = listOf<Any>()
    var resultData = hashMapOf<String, Any>()

    fun genNewWallet(){
        val strength = callData[0] as Int
        val passphrase = callData[1] as String
        val wallet = HDWallet(strength, passphrase)
        createAddress(wallet)

    }

    fun importNewWalletByMnemonic() {
        val mnemonic = callData[0] as String
        try {
            val wallet = HDWallet(mnemonic, "")
            createAddress(wallet)
        }
        catch (exp: InvalidParameterException) {
            updateResultFailure(400)
        }
    }

    fun importNewWalletByPrivateKey() {
        val key = callData[0] as String
        if (key.contains("0x")) {
            key.drop(2)
        }
        val dataKey = key.hexStringToByteArray()
        val isValidKey = PrivateKey.isValid(key.hexStringToByteArray(), CoinType.SMARTCHAIN.curve())
        if (isValidKey) {
            val privateKey = PrivateKey(key.hexStringToByteArray())
            val address = CoinType.SMARTCHAIN.deriveAddress(privateKey)
            val walletModel = WalletModel("", key,address)
            updateResultSuccess(walletModel.toMap())
        }
        else {
            updateResultFailure(400)
        }
    }

    private  fun createAddress(wallet: HDWallet) {
        val privateKey =  wallet.getKey(CoinType.SMARTCHAIN, CoinType.SMARTCHAIN.derivationPath())
        val address = CoinType.SMARTCHAIN.deriveAddress(privateKey)
        val walletModel =  WalletModel(wallet.mnemonic(), privateKey.data().toHexString(false), address)
        updateResultSuccess(walletModel.toMap())

    }

    private fun updateResultSuccess(body: HashMap<String, kotlin.Any>) {
        resultData["body"] = body
        resultData["code"] = 200
    }
    private  fun updateResultFailure(code: Int) {
        resultData["body"] = ""
        resultData["code"] = code
    }

    private fun String.hexStringToByteArray() : ByteArray {
        val hexChars = "0123456789ABCDEF"
        val result = ByteArray(this.length / 2)
        for (i in 0 until length step 2) {
            val firstIndex = hexChars.indexOf(this[i].toUpperCase());
            val secondIndex = hexChars.indexOf(this[i + 1].toUpperCase());
            val octet = firstIndex.shl(4).or(secondIndex)
            result[i.shr(1)] = octet.toByte()
        }
        return result
    }

    private fun ByteArray.toHexString(withPrefix: Boolean = true): String {
        val stringBuilder = StringBuilder()
        if(withPrefix) {
            stringBuilder.append("0x")
        }
        for (element in this) {
            stringBuilder.append(String.format("%02x", element and 0xFF.toByte()))
        }
        return stringBuilder.toString()
    }

}

data class WalletModel(val mnemonic: String, val privateKey: String, val address: String) {
    fun toMap():HashMap<String, Any> {
        return hashMapOf<String, Any>("mnemonic" to mnemonic, "privateKey" to privateKey, "address" to address)
    }
}


