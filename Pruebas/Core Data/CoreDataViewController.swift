//
//  CoreDataViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 06/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import CoreData



class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends: [Friend] = []
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Friends"
        
        return search
    }()
    
    //CoreData properties
    private let appDelegate =   UIApplication.shared.delegate as! AppDelegate
    private let context     =   (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFromCoreData()
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.save(name: nameToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func save(name: String) {
        let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.name = name
        friend.address = "Address for \(name)"
        
        appDelegate.saveContext()
        
        friends.append(friend)
        let index = IndexPath(row: friends.count - 1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    fileprivate func readFromCoreData() {
        
        let request =   Friend.fetchRequest() as NSFetchRequest
        let sort    =   NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            friends = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


extension CoreDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].name
        
        return cell
    }
}



extension CoreDataViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let predicate = Friend.fetchRequest() as NSFetchRequest
        predicate.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchController.searchBar.text!)
        
        do {
            friends = try context.fetch(predicate)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}






//class CoreDataViewController: UIViewController {
//
//@IBOutlet weak var tableView: UITableView!
//
//    var people: [NSManagedObject] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "The list"
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fecthRequest = NSFetchRequest<NSManagedObject>(entityName: "Person1")
//
//        do {
//            people = try managedContext.fetch(fecthRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//    }
//
//    @IBAction func addName(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController(title: "New Name",
//                                      message: "Add a new name",
//                                      preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) {
//                                        [unowned self] action in
//
//                                        guard let textField = alert.textFields?.first,
//                                            let nameToSave = textField.text else {
//                                                return
//                                        }
//
//                                        self.save(name: nameToSave)
//                                        self.tableView.insertRows(at: [IndexPath(row: self.people.count - 1, section: 0)], with: .automatic)
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .cancel)
//
//        alert.addTextField()
//
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true)
//    }
//
//    func save(name: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Person1", in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        person.setValue(name, forKey: "name")
//
//        do {
//            try managedContext.save()
//            people.append(person)
//        } catch {
//            print("Could not save. \(error.localizedDescription), \(String(describing: error._userInfo))")
//        }
//    }
//
//}
//
//
//extension CoreDataViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return people.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let person = people[indexPath.row]
//
//        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
//
//        return cell
//    }
//
//}
