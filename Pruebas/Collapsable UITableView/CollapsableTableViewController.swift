//
//  CollapsableTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 11/8/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class CollapsableTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    var swipeGesture: UISwipeGestureRecognizer?
    var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture?.direction = .left
        
        self.view.addGestureRecognizer(swipeGesture!)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && !isHidden {
            return 160
        } else if indexPath.row != 0  {
            return 80
        } else if indexPath.row == 0 && isHidden {
            return 0
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == 0 && !isHidden {
            cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath)
        }
        
        return cell
    }
    
    @objc func swipe() {
       
        if isHidden {
            isHidden = false
        } else {
            isHidden = true
        }
        
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
}
