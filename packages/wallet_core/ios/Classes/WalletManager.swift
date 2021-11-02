//
//  WalletManager.swift
//  wallet_core
//
//  Created by niBVL on 31/10/2021.
//

import Foundation
import WalletCore

class WalletManager {
    
    var callData = [Any]()
    var resultData: [String: Any] = ["code": 200]
    
    func genNewWallet() {
        let strength = callData[0] as! Int32
        let passphrase = callData[1] as! String
        let wallet = HDWallet(strength: strength, passphrase: passphrase)
        createAddress(wallet)
    }
    
    func importNewWalletByMnemonic()  {
        let mnemonic = callData[0] as! String
        if HDWallet.isValid(mnemonic: mnemonic) {
            let wallet = HDWallet.init(mnemonic: mnemonic, passphrase: "")
            createAddress(wallet)
        }
        else {
            updateResultFailure(400)
        }
        
        
    }
    
    func importNewWalletByPrivateKey()  {
        let key = callData[0] as! String
        let keyData = Data.init(hexString: key)
        if let safeKeyData = keyData {
            let isValid = PrivateKey.isValid(data: safeKeyData, curve: CoinType.smartChain.curve)
            if isValid {
                let privateKey = PrivateKey(data: safeKeyData)
                if let safePrivateKey = privateKey {
                    let address = CoinType.smartChain.deriveAddress(privateKey: safePrivateKey)
                    let walletModel = WalletModel(mnemonic: "", privateKey: key, address: address )
                    updateResultSuccess(walletModel.toDic())
                    return
                }
                
            }
        }
        updateResultFailure(400)
    }
    
    
    private func createAddress(_ wallet: HDWallet) {
        let privateKey = wallet.getKey(coin: CoinType.smartChain, derivationPath: CoinType.smartChain.derivationPath())
        let address = CoinType.smartChain.deriveAddress(privateKey: privateKey)
        let walletModel = WalletModel(mnemonic: wallet.mnemonic, privateKey: privateKey.data.hexString, address: address)
        updateResultSuccess(walletModel.toDic())
        
    }
    
    private func updateResultSuccess(_ body: [String:Any]) {
        resultData.updateValue(body, forKey: "body")
        resultData.updateValue(200, forKey: "code")
    }
    
    private func updateResultFailure(_ code: Int) {
        resultData.updateValue("", forKey: "body")
        resultData.updateValue(code, forKey: "code")
    }

}

struct WalletModel {
    let mnemonic: String
    let privateKey: String
    let address: String
        
    func toDic() -> [String: String]{
        return ["mnemonic": mnemonic, "privateKey": privateKey, "address": address]
    }
    
}

