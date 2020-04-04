//
//  AddressSuperView.swift
//  Pruebas
//
//  Created by Julio Banda on 23/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class AddressSuperView: UIView {

    var view: AddressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        view = Bundle(for: AddressView.self).loadNibNamed(String.init(describing: AddressView.self), owner: self)?.first as? AddressView
        view?.frame = bounds
        
       addSubview(view!)
    }
    
    func updateAddressValues(street: String, city: String, state: String, zipCode: String) {
        
    }

}
