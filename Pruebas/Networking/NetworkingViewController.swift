//
//  NetworkingViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 05/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import UILoadControl

class NetworkingViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var contactsTableView: UITableView!
    
    var control: UILoadControl?
    
    var selectedIndexPath = IndexPath(row: -1, section: 0)
    
    var contacts = [User]()
    var currentPageIndex = 0
    let pageSize = 10
    var noMorePages = false
    var loadingPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        control = UILoadControl(target: self, action: #selector(loadNextPage))
        contactsTableView.loadControl = control
        control?.heightLimit = 80
        loadNextPage()
        
    }
    
    @objc func loadNextPage() {
        if (control?.isTracking)! {
            print("Tracking")
        }
        
        if noMorePages || loadingPage {
            self.loadingPage = false
            self.control?.endLoading()
            return
        }

        loadingPage = true
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ContactsManager().downloadUsers(page: currentPageIndex) { (success, users) in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.loadingPage = false
                self.control?.endLoading()
                self.contacts.append(contentsOf: users.results)
                self.contactsTableView.reloadData()
                self.currentPageIndex += 1
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let detail = segue.destination as! ContactDetailViewController
            detail.contact = sender as! User
        }
    }

}

extension NetworkingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == contacts.count - 1 && contacts.count <= 15{
            loadNextPage()
        }
        
        if contacts.count == 30 {
            noMorePages = true
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        let cell = tableView.cellForRow(at: selectedIndexPath)
        cell!.textLabel?.numberOfLines = 0
        
        contactsTableView.reloadData()
        
        let contact = contacts[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: contact)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedIndexPath.row {
            return UITableViewAutomaticDimension
        }
        
        return contactsTableView.rowHeight
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
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



















