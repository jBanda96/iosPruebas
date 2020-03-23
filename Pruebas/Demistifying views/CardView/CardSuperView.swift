//
//  CardSuperView.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class CardSuperView: UIView {

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

}
