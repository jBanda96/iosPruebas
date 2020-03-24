//
//  CardSuperView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CardSuperView: UIView {
    
    var handleFlip: ((_ destination: CardView.Side) -> Void)?
    
    var cardViews: [CardView] {
        return subviews as! [CardView]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addCardViews()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addCardViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }

    func addCardViews() {
        for cardView in Bundle(for: CardView.self).loadNibNamed(String.init(describing: CardView.self), owner: self)! {
            addSubview(cardView as! CardView, constrainedTo: self)
        }
    }

    @IBAction func handleTap(_ sender: CardView) {
        sender.flip()
        handleFlip?(sender.otherSide.side)
    }
    
    func setCard(_ card: Card, side: CardView.Side, flip: Bool) {
        for cardView in cardViews {
            cardView.card = card
        }
    }
    
}
