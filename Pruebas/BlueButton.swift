//
//  BlueButton.swift
//  Pruebas
//
//  Created by Julio Banda on 29/12/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class BlueButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.tintColor = .white
        self.backgroundColor = UIColor.init(displayP3Red: 9/256, green: 43/256, blue: 69/256, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        
    }

}
