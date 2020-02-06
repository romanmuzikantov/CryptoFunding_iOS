//
//  ViewController.swift
//  CryptoFunding
//
//  Created by student5308 on 30/01/2020.
//  Copyright © 2020 student5308. All rights reserved.
//

import UIKit
import Web3swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let repoInstance = WalletRepositoryFactory.getFakeDaoRepository()
        let wallet = WalletHandler.generateWalletFromPrivateKey(privateKey: "7EB64DDB45D47DEF728B97D2B539B62CE7FCBF278D9610C96D8ED279A527FC96", password: "test", walletName: "MyWallet")!
        repoInstance.setCurrent(wallet: wallet)
        let currentWallet = WalletRepository.instance.getCurrent()
        if let currentWallet = currentWallet {
            let writeTx = SimpleTestContract.deploy(address: currentWallet.getAddress()!)
            if let writeTx = writeTx {
                let estimatedGasCost = Web3Util.estimateGasCost(tx: writeTx)
                print(estimatedGasCost ?? "")
                guard let sentTx = Web3Util.writeTransaction(tx: writeTx, password: "test") else {return}
                print(sentTx.hash)
                Web3Util.getTransactionReceipt(hash: sentTx.hash)
                print("test")
            }
        }
        
    }


}

