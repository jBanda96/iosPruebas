//
//  CADisplayLinkViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 24/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class CADisplayLinkViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var displayLink: CADisplayLink?
    
    var startValue: Double = 0
    var endValue: Double = 1000
    
    let animationDuration: Double = 1.5
    let animationStartDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create CADisplayLink
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .current, forMode: .defaultRunLoopMode)
    }
    
    @objc func handleUpdate() {
        
        let now = Date()
        let elapseTime = now.timeIntervalSince(animationStartDate)
        
        if elapseTime > animationDuration {
            self.label.text = "\(endValue)"
        } else {
            
            let percentage = elapseTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.label.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)
            self.label.text = "\(value)"
            
        }
        
    }

}
