//
//  FrontCardView.swift
//  Pruebas
//
//  Created by Julio Banda on 2/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class FrontCardView: DFCardView {
    
    @IBOutlet var imageView: FrontCardImageView!
    
    override var card: Card! {
        didSet {
            imageView.maskImage = card.image
        }
    }
    
    override var side: Side {
        return .front
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
