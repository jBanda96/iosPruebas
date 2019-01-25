//
//  CheckListCell.swift
//  Pruebas
//
//  Created by Julio Banda on 1/4/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class CheckListCell: UITableViewCell {

    @IBOutlet weak var checkmarkLabel: UILabel!
    @IBOutlet weak var todoTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
