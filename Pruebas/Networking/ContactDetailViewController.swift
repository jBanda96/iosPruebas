//
//  ContactDetailViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 19/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    var contact: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = contact.email
        
    }

}
