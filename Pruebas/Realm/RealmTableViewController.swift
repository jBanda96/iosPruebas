//
//  RealmTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 17/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class RealmTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBManager.sharedInstance.getDataFromDB().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "realmCell", for: indexPath)
        
        let index = Int(indexPath.row)
        let objeto = DBManager.sharedInstance.getDataFromDB() [index]
        
        cell.textLabel?.text = objeto.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row > -1 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            let index = Int(indexPath.row)
            
            let object = DBManager.sharedInstance.getDataFromDB() [index]
            
            vc.object = object
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.object = nil
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
