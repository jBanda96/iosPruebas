//
//  AddressView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class AddressView: UIView {

    @IBOutlet var streetTextField:  UITextField!
    @IBOutlet var cityTextField:    UITextField!
    @IBOutlet var stateTextField:   UITextField!
    @IBOutlet var zipCodeTextField: UITextField!
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius  = cornerRadius
        }
    }
    
}
