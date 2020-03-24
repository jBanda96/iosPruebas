//
//  LessonsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 23/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController {

    @IBOutlet var cardSuperView: CardSuperView! {
        didSet {
            cardSuperView.handleFlip = { [unowned self] _ in self.pickNewCard() }
        }
    }
    
    var cards: [Card]!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickNewCard()
    }
    
    func pickNewCard() {
        let card = cards.randomElement()!
        cardSuperView.setCard(card, side: .front, flip: false)
    }
    
}
