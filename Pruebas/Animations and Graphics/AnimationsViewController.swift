//
//  AnimationsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 01/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {

    @IBOutlet weak var face: CustomView!
    
    var fixedLayer: CAShapeLayer!
    var progressiveLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let radius = 150
        let rect = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        
        fixedLayer = getShapeLayerForRect(rect: rect, strokeColor: UIColor.black.withAlphaComponent(0.5))
        
        progressiveLayer = getShapeLayerForRect(rect: rect, strokeColor: .black)
        progressiveLayer.bounds = fixedLayer.bounds
        progressiveLayer.strokeEnd = 0
        
        self.view.layer.addSublayer(fixedLayer)
        self.view.layer.addSublayer(progressiveLayer)
        
    }
    
    private func getShapeLayerForRect(rect: CGRect, strokeColor sColor: UIColor) -> CAShapeLayer {
        
        let radius = rect.width / 2 - 10 / 2
        let newRect = CGRect(x: 50 / 2, y: 150 / 2, width: radius * 2, height: radius * 2)
        
        let path = UIBezierPath(roundedRect: newRect, cornerRadius: radius).cgPath
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.strokeColor = sColor.cgColor
        shape.lineCap = kCALineCapRound
        shape.lineWidth = 10
        shape.fillColor = nil
        
        return shape
        
    }
    
    @IBAction func didClickDownloadButton(_ sender: UIButton) {
        progressiveLayer.strokeEnd = 0.75
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 0.75
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        progressiveLayer.add(animation, forKey: nil)
    }
    
    @IBAction func makeSmile(_ sender: UISlider) {
        face.satisfaction = CGFloat(sender.value)
    }
    
    @IBAction func didClickOnSaveButton(_ sender: UIButton) {
        let image = self.face.screenshot
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

}

extension UIView {
    var screenshot: UIImage {
        
        UIGraphicsBeginImageContext(self.bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenShot!
        
    }
}
