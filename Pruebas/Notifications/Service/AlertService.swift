//
//  AlertService.swift
//  Pruebas
//
//  Created by Julio Banda on 11/13/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

class AlertService {
    
    private init(){}
    
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping () -> Void){
        
        let alert   =   UIAlertController(title: nil,
                                          message: nil,
                                          preferredStyle: .actionSheet)
        
        let action  =   UIAlertAction(title: title,
                                      style: .default) { (_) in
                                        completion()
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
        
    }
    
}
