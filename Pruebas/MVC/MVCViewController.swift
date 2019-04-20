//
//  MVCViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import PDFKit

class MVCViewController: UIViewController {
    
    let pdf: PDFView = {
        let pdf = PDFView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return pdf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
}

