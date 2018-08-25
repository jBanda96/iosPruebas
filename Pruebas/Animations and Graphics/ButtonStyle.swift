//
//  ButtonStyle.swift
//  Pruebas
//
//  Created by Julio Banda on 24/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

@IBDesignable class ButtonStyle: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var clipToBounds: Bool = false {
        didSet {
            self.clipsToBounds = clipToBounds
        }
    }
    
}
