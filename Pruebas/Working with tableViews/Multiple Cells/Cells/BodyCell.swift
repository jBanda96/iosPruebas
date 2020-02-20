//
//  BodyCell.swift
//  Pruebas
//
//  Created by Julio Banda on 29/12/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class BodyCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
