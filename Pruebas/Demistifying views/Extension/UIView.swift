//
//  UIView.swift
//  Pruebas
//
//  Created by Julio Banda on 2/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubview(_ subview: UIView, constrainedTo anchorsView: UIView){
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
            ])
    }
    
    func roundCorners(){
        let cardRadius = bounds.maxX / 6
        layer.cornerRadius = cardRadius
    }
}
