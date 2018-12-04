//
//  BullEyeGameViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 12/2/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class BullEyeGameViewController: UIViewController {

    var orientation = UIInterfaceOrientation.landscapeLeft.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIDevice.current.setValue(orientation, forKey: "orientation")
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        let alert: UIAlertController    =   UIAlertController(title: "",
                                                              message: "",
                                                              preferredStyle: .alert)
        
        let action: UIAlertAction       =   UIAlertAction(title: "",
                                                          style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }

}
