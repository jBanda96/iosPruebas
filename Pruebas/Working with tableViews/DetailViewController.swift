//
//  DetailViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 10/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var info: Texts!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = info.string
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func edit(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: self)
    }

}
