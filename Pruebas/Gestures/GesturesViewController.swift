//
//  GesturesViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 02/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    
    @IBOutlet weak var sampleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPanGesture()
        
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        self.sampleView.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        let point = gesture.location(in: self.view)
        self.sampleView.center = point
        
    }
    
}
