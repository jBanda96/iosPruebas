//
//  NoNavigationBarViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 2/14/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class NoNavigationBarViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

}
