//
//  FrontCardView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

class FrontCardView: CardView {
    @IBOutlet var imageView: FrontCardImageView!
    
    override var side: CardView.Side { .front }
    
    override var card: Card! {
        didSet {
            imageView.maskImage = card.image
        }
    }
}

@IBDesignable class FrontCardImageView: UIImageView {
    @IBInspectable var maskImage: UIImage! {
        didSet {
            mask = UIImageView(image: maskImage)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mask?.frame = bounds
    }
    
}
