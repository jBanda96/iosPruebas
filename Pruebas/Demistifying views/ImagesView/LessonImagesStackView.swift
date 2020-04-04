//
//  LessonImagesStackView.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 3/24/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class LessonImagesStackView: UIStackView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addCardViews()
    }
    
    func addCardViews(owner: Any? = nil) {
        let nib = UINib.init(nibName: String.init(describing: CardView.self), bundle: Bundle(for: CardView.self))
        
        for subview in subviews as! [UIStackView] {
            let cardViews = subviews.map { _ in
                nib.instantiate(withOwner: owner).first { first -> Bool in first is FrontCardView }
            } as! [FrontCardView]
            
            cardViews.forEach(subview.addArrangedSubview(_:))
        }
        
    }

}
