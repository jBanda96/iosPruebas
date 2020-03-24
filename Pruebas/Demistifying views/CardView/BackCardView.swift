//
//  FrontCardView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

class BackCardView: CardView {
    @IBOutlet var label: UILabel!
    
    override var side: CardView.Side { .back }
    
    override var card: Card! {
        didSet {
            label.text = card.name
        }
    }
}
