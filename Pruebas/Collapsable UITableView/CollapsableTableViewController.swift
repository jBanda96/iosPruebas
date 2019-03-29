//
//  CollapsableTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 11/8/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class StretchyHeaderController: UICollectionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
}
