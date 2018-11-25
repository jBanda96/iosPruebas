//
//  StatusPill.swift
//  Pruebas
//
//  Created by Julio Banda on 11/19/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

class StatusPill: UIView {
    
    var color: UIColor! {
        didSet {
            self.layer.borderColor  =   color.cgColor
            self.label.textColor    =   color
        }
    }
    
    var text: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit(){
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint      (equalTo: self.centerXAnchor)                   .isActive = true
        label.centerYAnchor.constraint      (equalTo: self.centerYAnchor)                   .isActive = true
        label.widthAnchor.constraint        (equalTo: self.widthAnchor, constant: -30)      .isActive = true
        label.heightAnchor.constraint       (equalTo: self.heightAnchor, constant: -30)     .isActive = true
        
        label.font = UIFont(name: "Helvetica-Light", size: 40)
        
        self.layer.borderWidth = 3.0
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
}
