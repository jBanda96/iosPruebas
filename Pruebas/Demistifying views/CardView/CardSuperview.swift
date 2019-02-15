//
//  CardSuperview.swift
//  Pruebas
//
//  Created by Julio Banda on 2/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CardSuperview: UIView {
    
    var handleFlip: ((_ destination: DFCardView.Side) -> Void)?
    
    var cardViews: [DFCardView] {
        return subviews as! [DFCardView]
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

    func addCardViews(){
        for cardView in Bundle(for: CardView.self).loadNibNamed("\(CardView.self)", owner: self)! {
            addSubview(cardView as! FrontCardView, constrainedTo: self)
        }
    }
    
    @IBAction func handleTap(_ sender: DFCardView) {
        sender.flip()
        handleFlip?(.front)
    }
    
    func setCard(_ card: Card, side: DFCardView.Side, flip: Bool) {
        for cardView in cardViews {
            cardView.card = card
        }
    }

}
