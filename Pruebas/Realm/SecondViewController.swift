//
//  SecondViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 17/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtNote: UITextField!
    
    var object: Objecto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let objecto = object {
            txtNote.text = objecto.name
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        let objectToSave = Objecto()
        
        if object == nil {
            objectToSave.id = DBManager.sharedInstance.getDataFromDB().count
        }
        
        objectToSave.name = txtNote.text!
        
        DBManager.sharedInstance.addData(object: objectToSave)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        
        if let objectToDelete = object {
            DBManager.sharedInstance.deleteFromDb(object: objectToDelete)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}
