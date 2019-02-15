//
//  CardView.swift
//  Pruebas
//
//  Created by Julio Banda on 2/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class DFCardView: UIControl {

    enum Side {
        case front, back
    }
    
    var card: Card!
    
    var side: Side { fatalError() }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        roundCorners()
    }
    
    func flip(to side: Side? = nil) {
        UIView.transition(from: self, to: self, duration: 0.35, options: [.transitionFlipFromRight, .showHideTransitionViews])
    }

}
