//
//  MVCViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MVCViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var person: ModelMVC!
    
    @IBAction func greet(_ button: UIButton){
        self.label.text = "Hello \(person.firstName) \(person.surName)"
    }

}
