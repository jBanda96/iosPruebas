//
//  NewWayViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 23/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class NewWayViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var percentage: PercentageView!
    
    override func viewDidLoad() {
        
        label.text = "\(stepper.value)"
        
        super.viewDidLoad()
    }
    
    @IBAction func userDidClickOnStepper(_ sender: UIStepper) {
        
        var from = 0.0
        var to = 0.0
        
        if Double(label.text!)! > stepper.value {
            from = Double(label.text!)!
            to = stepper.value
        } else {
            from = Double(label.text!)!
            to = stepper.value
        }
        
        label.text = "\(stepper.value)"
        
        percentage.frontLayer.strokeEnd = CGFloat(stepper.value)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        percentage.frontLayer.add(animation, forKey: nil)
        
    }

}
