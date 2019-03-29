//
//  HeaderView.swift
//  Pruebas
//
//  Created by Julio Banda on 3/25/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let image: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints     =   false
        imageView.contentMode                                   =   .scaleToFill
        imageView.image                                         =   #imageLiteral(resourceName: "mountains_landscape")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(image)
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
