//
//  CustomTabBarViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 14/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class CustomTabBarController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstTextField: UITextField!
    let numberFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        numberFormatter.locale = Locale(identifier: "es_MX")
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.maximumIntegerDigits = 15
        numberFormatter.numberStyle = .decimal
        
        firstTextField.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        
    }
    
    @objc func textfieldDidChanged(_ textfield: UITextField) {
        
        
        
    }

}
