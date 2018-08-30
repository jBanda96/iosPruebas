//
//  AndroidTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 08/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class AndroidTableViewController: UITableViewController {

    var words = [Word]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = .brown
        self.navigationController?.navigationBar.tintColor = .white
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - TableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            
            words = [Word(mDefaultTranslation: "One", mSpanishTranslation: "Uno", mImageResourceId: #imageLiteral(resourceName: "number_one")),
                     Word(mDefaultTranslation: "Two", mSpanishTranslation: "Dos", mImageResourceId: #imageLiteral(resourceName: "number_two")),
                     Word(mDefaultTranslation: "Three", mSpanishTranslation: "Tres", mImageResourceId: #imageLiteral(resourceName: "number_three")),
                     Word(mDefaultTranslation: "Four", mSpanishTranslation: "Cuatro", mImageResourceId: #imageLiteral(resourceName: "number_four")),
                     Word(mDefaultTranslation: "Five", mSpanishTranslation: "Cinco", mImageResourceId: #imageLiteral(resourceName: "number_five")),
                     Word(mDefaultTranslation: "Six", mSpanishTranslation: "Seis", mImageResourceId: #imageLiteral(resourceName: "number_six")),
                     Word(mDefaultTranslation: "Seven", mSpanishTranslation: "Siete", mImageResourceId: #imageLiteral(resourceName: "number_seven")),
                     Word(mDefaultTranslation: "Eight", mSpanishTranslation: "Ocho", mImageResourceId: #imageLiteral(resourceName: "number_eight")),
                     Word(mDefaultTranslation: "Nine", mSpanishTranslation: "Nueve", mImageResourceId: #imageLiteral(resourceName: "number_nine")),
                     Word(mDefaultTranslation: "Ten", mSpanishTranslation: "Diez", mImageResourceId: #imageLiteral(resourceName: "number_ten"))]
            
        }
        
        performSegue(withIdentifier: "showDetailSegue", sender: words)
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetailSegue" {
            
            let wordsVC = segue.destination as! WordViewController
            wordsVC.words = self.words
            
        }
    }
    
    deinit {
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.tintColor = .blue
    }

}
