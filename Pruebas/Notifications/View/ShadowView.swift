//
//  ShadowView.swift
//  Pruebas
//
//  Created by Julio Banda on 11/13/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {

    override func draw(_ rect: CGRect) {
        
        layer.shadowPath    =   CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor   =   UIColor.black.cgColor
        layer.shadowOffset  =   CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius  =   50.0
        layer.shadowOpacity =   0.5
    }
    
    override func awakeFromNib() {
        
    }

}
