//
//  LessonsImageView.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 3/24/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@IBDesignable class LessonsImageView: UIView {

    @IBOutlet var stackView: LessonImagesStackView! {
        didSet {
            stackView.addCardViews(owner: self)
        }
    }
    
    var cards: [Card]!
    var correctCard: Card!
    
    @objc func handleTap(_ sender: FrontCardView) {
        
    }
    
}
