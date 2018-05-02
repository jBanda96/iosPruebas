//
//  FirstViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 01/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
        
        let sourceViewController = segue.source
        
        switch sourceViewController {
        case is RedViewController:
            print("Coming from red")
        case is BlueViewController:
            print("Coming from blue")
        default:
            return
        }
        
    }
    
}
