//
//  CardStack.swift
//  Pruebas
//
//  Created by Julio Banda on 11/18/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

class CardStack: UIView {

    var cards: [CardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    func defaultInit(){
        for person in people {
            addPerson(person: person)
        }
    }
    
    func addPerson(person: Person) {
        let card = CardView()
            card.person = person
        
        self.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        card.topAnchor.constraint       (equalTo:   self.topAnchor)         .isActive = true
        card.bottomAnchor.constraint    (equalTo:   self.bottomAnchor)      .isActive = true
        card.leadingAnchor.constraint   (equalTo:   self.leadingAnchor)     .isActive = true
        card.trailingAnchor.constraint  (equalTo:   self.trailingAnchor)    .isActive = true
        
        cards.append(card)
        self.sendSubview(toBack: card)
        
        setUpTransforms(percentCompletion: 0)
        
        if cards.count == 1 {
            card.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                             action: #selector(pan(gesture:))))
        }
    }
    
    func setUpGestures() {
        for card in cards {
            let gestures = card.gestureRecognizers ?? []
            
            for gesture in gestures {
                card.removeGestureRecognizer(gesture)
            }
            
            if let firstCard = cards.first {
                firstCard.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                                      action: #selector(pan(gesture:))))
            }
        }
    }
    
    @objc
    func pan(gesture: UIPanGestureRecognizer){
        let card        =   gesture.view as! CardView
        let translation =   gesture.translation(in: self)
        
        var rotationPercentage: CGFloat = translation.x / self.bounds.midX
        rotationPercentage = min(rotationPercentage, 1)
        rotationPercentage = max(rotationPercentage, -1)
        
        let transform   =   CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation    =   CGAffineTransform(rotationAngle: rotationPercentage * .pi / 40)
        
        transform.concatenating(rotation)
        card.transform = transform
        
        if rotationPercentage > 0.2 {
            card.nopeLabel.alpha    =   0
            
            let newPercent          =   (rotationPercentage - 0.2) / 0.8
            card.likeLabel.alpha    =   newPercent
            
        } else if rotationPercentage < -0.2 {
            card.likeLabel.alpha    =   0
            
            let newPercent          =   (abs(rotationPercentage) - 0.2) / 0.8
            card.nopeLabel.alpha    =   newPercent
            
        } else {
            card.likeLabel.alpha    =   0
            card.nopeLabel.alpha    =   0
        }
        
        if  gesture.state == .ended {
            
            if rotationPercentage > 0.2 || rotationPercentage < -0.2{
                
                UIView.animate(withDuration: 0.5, animations: {
                    card.alpha = 0
                }) { (_) in
                    self.cards.remove(at: self.cards.firstIndex(of: card)!)
                    self.setUpGestures()
                    card.removeFromSuperview()
                }
                
            } else {
                UIView.animate(withDuration: 0.6,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 1,
                               options: [],
                               animations: {
                                card.transform = .identity
                })
                
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 1,
                               options: [],
                               animations: {
                                card.likeLabel.alpha    =   0
                                card.nopeLabel.alpha    =   0
                })
            }
        }
    }
    
    func setUpTransforms(percentCompletion: Double) {
        for (index, card) in cards.enumerated() {
            if index == 0 { continue }
            
            let remainder = index.remainderReportingOverflow(dividingBy: 2).partialValue
            
            let transformation: CGAffineTransform
            let translation:    CGAffineTransform
            let rotation:       CGAffineTransform
            
            if remainder == 0 {
                translation =   CGAffineTransform(translationX: CGFloat(index) * 4, y: 0)
                rotation    =   CGAffineTransform(rotationAngle: 5 * .pi / 180)
                
            } else {
                translation =   CGAffineTransform(translationX: -CGFloat(index) * 4, y: 0)
                rotation    =   CGAffineTransform(rotationAngle: 355 * .pi / 180)
            }
            
            transformation = translation.concatenating(rotation)
            
            UIView.animate(withDuration: 1.8) {
                card.transform = transformation
            }
            
        }
    }
    
}
