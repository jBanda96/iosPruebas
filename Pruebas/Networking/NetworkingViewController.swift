//
//  NetworkingViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 05/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class NetworkingViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var contactsTableView: UITableView!
    
    var selectedIndexPath = IndexPath(row: -1, section: 0)
    
    var contacts = [User]()
    var currentPageIndex = 0
    let pageSize = 10
    var noMorePages = false
    var loadingPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNextPage()
        
    }
    
    func loadNextPage() {
        
        if noMorePages || loadingPage {
            return
        }

        loadingPage = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ContactsManager().downloadUsers(page: currentPageIndex) { (success, users) in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.loadingPage = false
                self.contacts.append(contentsOf: users.results)
                self.contactsTableView.reloadData()
                self.currentPageIndex += 1
                
            }
            
        }
        
//
//        let contactsManager = ContactsManager()
//        contactsManager.fetchContacts(page: currentPageIndex, pageSize: pageSize) { (success, newContacts) in
//
//            DispatchQueue.main.async {
//
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//                self.loadingPage = false
//
//                if success {
//                    if newContacts.isEmpty {
//                        self.noMorePages = true
//                    } else {
//                        self.contacts.append(contentsOf: newContacts)
//                        self.contactsTableView.reloadData()
//                        self.currentPageIndex += 1
//                    }
//
//                }
//
//            }
//
//        }
//
    }

}

extension NetworkingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.contacts.count - 1 {
            loadNextPage()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        let cell = tableView.cellForRow(at: selectedIndexPath)
        cell!.textLabel?.numberOfLines = 0
        
        contactsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedIndexPath.row {
            return UITableViewAutomaticDimension
        }
        
        return contactsTableView.rowHeight
        
    }
    
}


extension NetworkingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        let contact = self.contacts[indexPath.row]
        
        cell.textLabel?.text = "\(contact.email) - Number \(indexPath.row)"
        
        return cell
    }
    
    
}



















