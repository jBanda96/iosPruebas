//
//  FlyingSquaresViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 22/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class FlyingSquaresViewController: UIViewController {
    
    @IBOutlet weak var square: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2, delay: 1, options: [.repeat, .autoreverse, .curveEaseIn, .preferredFramesPerSecond60], animations: {
            self.square.backgroundColor = .red
            
            let rotationTransform = CGAffineTransform(rotationAngle: .pi)
            let scaleTransform = CGAffineTransform(scaleX: 2, y: 2)
            let translateTransform = CGAffineTransform(translationX: 50, y: -20)
            
            let comboTransform = rotationTransform.concatenating(scaleTransform).concatenating(translateTransform)
            self.square.transform = comboTransform
            
        }, completion: nil)
        
    }
}
