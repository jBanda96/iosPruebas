//
//  LottieViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 10/12/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimation()
    }

    private func startAnimation() {
        animationView.animation = Animation.named("animation")
        animationView.play()
    }
    
}
