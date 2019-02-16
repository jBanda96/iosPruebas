//
//  DIYScrollView.swift
//  Pruebas
//
//  Created by Julio Banda on 2/15/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class DIYScrollView: UIView {

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        
        bounds.origin.y = bounds.origin.y - translation.y
        recognizer.setTranslation(.zero, in: self)
        
    }

}
