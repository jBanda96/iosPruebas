//
//  CardView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    var card: Card!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners()
    }
    
}
