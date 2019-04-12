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

class AuthenticationViewController: UIViewController {
    
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
    }
    
    @IBAction func authenticate(_ button: UIButton) {
        
        context.localizedCancelTitle = "Enter password"
        
        context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            let reason = "Log into your account"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                
                if success {
                    print("Success")
                } else {
                    print("Error")
                }
                
            }
            
        } else {
            print("Error 2")
        }
        
    }

}
