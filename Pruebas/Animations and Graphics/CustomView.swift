//
//  CustomView.swift
//  Pruebas
//
//  Created by Julio Banda on 01/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {

    @IBInspectable var backColor: UIColor = .white
    @IBInspectable var strokeColor: UIColor = .black
    @IBInspectable var fillColor: UIColor = .black
    
    var satisfaction: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(backColor.cgColor)
            context.fill(self.bounds)
            
            context.setStrokeColor(strokeColor.cgColor)
            context.setLineWidth(3.0)
            
            let radius = min(rect.width, rect.height) * 0.75 / 2
            
            context.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                           radius: radius,
                           startAngle: 0,
                           endAngle: 2 * .pi,
                           clockwise: false)
            context.strokePath()
            
            
            context.addArc(center: CGPoint(x: rect.midX - radius / 2, y: rect.midY - radius / 2),
                           radius: radius / 15,
                           startAngle: 0,
                           endAngle: 2 * .pi,
                           clockwise: false)
            
            context.addArc(center: CGPoint(x: rect.midX + radius / 2, y: rect.midY - radius / 2),
                           radius: radius / 15,
                           startAngle: 0,
                           endAngle: 2 * .pi,
                           clockwise: false)
            
            let noseSize = CGSize(width: rect.width / 50, height: rect.height / 8)
            context.addRect(CGRect(x: rect.midX - noseSize.width / 2, y: rect.midY - noseSize.height / 2, width: noseSize.width, height: noseSize.height))
            
            context.setFillColor(fillColor.cgColor)
            context.fillPath()
            
            let startPoint = CGPoint(x: rect.midX - radius / 2, y: rect.midY + radius / 2)
            let endPoint = CGPoint(x: rect.midX + radius / 2, y: rect.midY + radius / 2)
            
            context.move(to: startPoint)
            
            let cp = CGPoint(x: rect.midX, y: startPoint.y * (satisfaction + 0.5))
            
            context.addQuadCurve(to: endPoint, control: cp)
            
            context.strokePath()
            
        }
        
    }

}
