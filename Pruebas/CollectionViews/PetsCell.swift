//
//  PetsCell.swift
//  Pruebas
//
//  Created by Julio Banda on 1/27/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class PetsCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? #imageLiteral(resourceName: "Checked") : #imageLiteral(resourceName: "Unchecked")
            }
        }
    }
    
}
