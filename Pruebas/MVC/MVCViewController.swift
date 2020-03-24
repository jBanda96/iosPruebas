//
//  MVCViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import PDFKit

class MVCViewController: NoNavigationBarViewController {
    
    internal struct Address {
        public var street:  String
        public var city:    String
        public var state:   String
        public var zipCode: String
    }
    
    internal var address: Address? {
        didSet {
            self.updateViewFromAddress()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewFromAddress()
        address = Address(street:   "Cuautitlán Izcalli",
                          city:     "Mexico",
                          state:    "Mexico",
                          zipCode:  "54749")
    }
    
    @IBAction func updateAddressFromView(_ sender: UIButton) {
//        guard let street    =     addressView.streetTextField.text,   street.count > 0,
//              let city      =     addressView.cityTextField.text,     city.count > 0,
//              let state     =     addressView.stateTextField.text,    state.count > 0,
//              let zipCode   =     addressView.zipCodeTextField.text,  zipCode.count > 0
//              else{ return }
//
//        address = Address(street:   street,
//                          city:     city,
//                          state:    state,
//                          zipCode:  zipCode)
    }
    
    private func updateViewFromAddress() {
//        guard let addressView = addressView, let address = address else { return }
//        addressView.streetTextField.text     =   address.street
//        addressView.cityTextField.text       =   address.city
//        addressView.stateTextField.text      =   address.state
//        addressView.zipCodeTextField.text    =   address.zipCode
    }
    
}

