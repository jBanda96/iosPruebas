//
//  PaginationViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 13/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class PaginationViewController: UITableViewController {
    
    private var number: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        Connections.downloadPerPage(num: number) { (response) in
            
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        return cell
    }

}
