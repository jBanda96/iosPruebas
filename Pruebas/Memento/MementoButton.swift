//
//  MementoButton.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 4/3/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class MementoButton: UIButton {

     @IBInspectable var alphaColor: UIColor = .clear {
        didSet {
            self.backgroundColor = alphaColor
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.height / 2
            
            let insets = UIEdgeInsetsMake(10, 10, 10, 10)
            self.contentEdgeInsets = insets
        }
    }

}
