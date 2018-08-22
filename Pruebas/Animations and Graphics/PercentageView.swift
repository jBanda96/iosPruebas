//
//  PercentageView.swift
//  Pruebas
//
//  Created by Julio Banda on 23/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class PercentageView: UIView {
    
    @IBInspectable var color: UIColor = .purple
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var width: CGFloat = 1
    
    let frontLayer = CAShapeLayer()
    
    @IBInspectable var strokeEnd: CGFloat = 0.0

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let radius = min(self.frame.width, self.frame.height) / 2
        let path = UIBezierPath(roundedRect: CGRect(x: width, y: width, width: (radius * 2) - (width * 2), height: (radius * 2) - (width * 2)), cornerRadius: radius).cgPath
        
        let backLayer = CAShapeLayer()
        backLayer.path = path
        backLayer.strokeColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        backLayer.lineWidth = width
        backLayer.fillColor = nil
        
        frontLayer.path = path
        frontLayer.strokeColor = color.cgColor
        frontLayer.lineWidth = width * 2
        frontLayer.lineCap = kCALineCapRound
        frontLayer.fillColor = nil
        frontLayer.strokeEnd = 0
        
        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(frontLayer)
        
    }

}
