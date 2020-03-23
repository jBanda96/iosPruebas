//
//  CardView.swift
//  Pruebas
//
//  Created by Julio Banda on 11/18/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

class CardViewA: UIView {
    
    var person : Person! {
        didSet {
            imageView.image     =       person.image
            nameLabel.text      =       person.name
            ageLabel.text       =       String(person.age)
        }
    }
    
    let likeLabel   =   StatusPill()
    let nopeLabel   =   StatusPill()
    
    let imageView   =   UIImageView()
    let nameLabel   =   UILabel()
    let ageLabel    =   UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    func defaultInit(){
        self.backgroundColor = .white
        
        let subviews            = [imageView, nameLabel, ageLabel]
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        imageView.topAnchor.constraint      (equalTo: self.topAnchor)                       .isActive = true
        imageView.leadingAnchor.constraint  (equalTo: self.leadingAnchor)                   .isActive = true
        imageView.trailingAnchor.constraint (equalTo: self.trailingAnchor)                  .isActive = true
        imageView.heightAnchor.constraint   (equalTo: self.heightAnchor, multiplier: 0.8)   .isActive = true
        
        nameLabel.topAnchor.constraint      (equalTo: imageView.bottomAnchor,   constant: 8)    .isActive = true
        nameLabel.leadingAnchor.constraint  (equalTo: self.leadingAnchor,       constant: 8)    .isActive = true
        nameLabel.bottomAnchor.constraint   (equalTo: self.bottomAnchor,        constant: -8)   .isActive = true
        
        ageLabel.topAnchor.constraint       (equalTo: imageView.bottomAnchor,   constant: 8)    .isActive = true
        ageLabel.trailingAnchor.constraint  (equalTo: self.trailingAnchor,      constant: -8)   .isActive = true
        ageLabel.bottomAnchor.constraint    (equalTo: self.bottomAnchor,        constant: -8)   .isActive = true
        
        nameLabel.font  =   UIFont(name: "HelveticaNeue-Light", size: 20)
        ageLabel.font   =   UIFont(name: "HelveticaNeue-Light", size: 17)
        
        self.layer.cornerRadius     =       10
        self.clipsToBounds          =       true
        
        self.imageView.contentMode      =       .scaleAspectFill
        self.imageView.clipsToBounds    =       true
        
        for v in [nopeLabel, likeLabel] {
            self.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            v.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            v.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            v.alpha = 0.0
        }
        
        nopeLabel.text      =       "Nope"
        nopeLabel.color     =       .init(red: 0.9, green: 0.29, blue: 0.23, alpha: 1)
        
        likeLabel.text      =       "Like"
        likeLabel.color     =       .init(red: 0.101, green: 0.737, blue: 0.611, alpha: 1)
        
    }
    
}
