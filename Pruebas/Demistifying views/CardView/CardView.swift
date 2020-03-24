//
//  CardView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIControl {

    enum Side {
        case front, back
    }
    
    @IBOutlet weak var otherSide: CardView!
    
    var card: Card!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners()
    }
    
    var side: Side { fatalError() }
    
    func flip(to side: Side? = nil) {
        UIView.transition(from: self,
                          to: side == self.side ? self : otherSide,
                          duration: 0.35,
                          options: [.transitionCrossDissolve, .showHideTransitionViews])
    }
    
}
