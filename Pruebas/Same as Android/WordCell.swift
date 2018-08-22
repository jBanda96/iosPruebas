//
//  WordCell.swift
//  Pruebas
//
//  Created by Julio Banda on 08/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    
    @IBOutlet weak var androidImage: UIImageView!
    @IBOutlet weak var english: UILabel!
    @IBOutlet weak var spanish: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
