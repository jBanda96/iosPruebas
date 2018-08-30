//
//  TableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 08/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class WordViewController: UITableViewController {

    var words: [Word]!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = .brown
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WordCell
        
        let word = words[indexPath.row]
        
        cell.english.text = word.mDefaultTranslation
        cell.spanish.text = word.mSpanishTranslation
        cell.androidImage.image = word.mImageResourceId == nil ? nil : word.mImageResourceId
        
        return cell
    }

}
