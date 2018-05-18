//
//  ButtonedTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 15/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class ButtonedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonedCell")
        
        return cell!
    }

    @IBAction func pressedCellButton(_ sender: UIButton) {
        print("Button pressed")
    }
    
}
