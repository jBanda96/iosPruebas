//
//  3DTouchViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 04/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import KeychainAccess

import LocalAuthentication

class _DTouchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyChain = Keychain(service: "com.myPersonalTeam.Pruebas.Pruebas")
        print("keys: \(keyChain.allKeys())")
        keyChain["session"] = "Julio Banda"
        
        if let session = keyChain["session"] {
            print(session)
            print(keyChain.allKeys())
        }
        
    }

    @IBAction func didClickOnAuthenticate(_ sender: UIButton) {
        
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed using the app") { (success, error) in
                
                if let error = error {
                    print(error)
                    self.showAlertWithMessage(msg: "A problem has occured while verification.")
                } else {
                    
                    if success {
                        self.showAlertWithMessage(msg: "Thanks! \nYou're the device owner and we can proceed now")
                    } else {
                        self.showAlertWithMessage(msg: "Authentication has been failed as you're not the device owner")
                    }
                    
                }
                
            }
            
        } else {
            showAlertWithMessage(msg: "Touch ID is not available in your device")
        }
        
    }
    
    func showAlertWithMessage(msg: String) {
        let alertController = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
