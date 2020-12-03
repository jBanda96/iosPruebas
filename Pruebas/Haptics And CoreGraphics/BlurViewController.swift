//
//  BlurViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 01/12/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

class BlurViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)

        
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: view.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

}
