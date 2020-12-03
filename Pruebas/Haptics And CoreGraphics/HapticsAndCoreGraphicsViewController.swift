//
//  HapticsAndCoreGraphics.swift
//  Pruebas
//
//  Created by Julio Banda on 24/11/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation

class HapticsAndCoreGraphicsViewController: UIViewController {
    
    @IBOutlet weak var blurContainerView: UIView!
    
    var haptics: HapticsManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nom haptics
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = .down
        swipeGesture.addTarget(self, action: #selector(swiping(_:)))
//        self.view.addGestureRecognizer(swipeGesture)
        
        //Splash haptics
        let tapGestures = UITapGestureRecognizer()
        tapGestures.addTarget(self, action: #selector(tapping(_:)))
//        self.view.addGestureRecognizer(tapGestures)
        
    }
    
    @objc func swiping(_: UISwipeGestureRecognizer){
        haptics = HapticsManager()
        haptics?.playSlice()
    }
    
    @objc func tapping(_: UISwipeGestureRecognizer){
        haptics = HapticsManager()
        haptics?.playTap()
    }
    
}

//MARK: - Blur
extension HapticsAndCoreGraphicsViewController {
    func setBlurHidden(_ hidden: Bool, animated: Bool) {
        
    }
}
