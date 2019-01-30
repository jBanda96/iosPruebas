//
//  DetailSegueViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/27/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class DetailSegueViewController: UIViewController {

    @IBOutlet weak var detailEmoji: UILabel!
    var selection: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailEmoji.text = selection
    }

}
