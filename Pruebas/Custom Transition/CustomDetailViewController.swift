//
//  CustomDetailViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/18/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class CustomDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textTitle: UILabel!
    
    @IBOutlet weak var centerHorizontalyConstraint: NSLayoutConstraint!
    @IBOutlet weak var topToImageConstraint: NSLayoutConstraint!
    
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = pet?.image
        textTitle.text = pet?.name
    }

    @IBAction func dismiss(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
