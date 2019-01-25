//
//  ToDoListController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/1/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    
    let list: TodoList
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        list = TodoList()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 44
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.setupNavigationController()
        
    }

    // MARK: - Table view data source and delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.numberOfTasks
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! CheckListCell
        let item = list.get(at: indexPath.row)
        cell.todoTextLabel.text = item.text
        
        if item.isChecked {
            cell.checkmarkLabel.text = "√"
        } else {
            cell.checkmarkLabel.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            let item = list.get(at: indexPath.row)
            item.toggle()
            
            tableView.beginUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        } else {
            print(self.tableView.indexPathsForSelectedRows ?? [])
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(self.tableView.indexPathsForSelectedRows ?? [])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            list.delete(item: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } 
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        list.move(item: list.get(at: sourceIndexPath.row), to: destinationIndexPath.row)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    @IBAction func deleteItems(_ sender: UIBarButtonItem?) {
        if let indexPathsForSelectedRows = self.tableView.indexPathsForSelectedRows {
            list.delete(items: indexPathsForSelectedRows)
            self.tableView.deleteRows(at: indexPathsForSelectedRows, with: .automatic)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            if let addItemViewController = segue.destination as? ItemDetailViewController {
                addItemViewController.delegate = self
                addItemViewController.todoList = list
            }
        } else if segue.identifier == "editItemSegue" {
            if let addItemViewController = segue.destination as? ItemDetailViewController {
                addItemViewController.delegate = self
                
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = list.get(at: indexPath.row)
                    addItemViewController.itemToEdit = item
                }
                
            }
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Customizations
    func setupNavigationController(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    deinit {
        list.retrieveAllTasks { (task) in
            print(task.description)
        }
    }

}

extension ToDoListController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        self.navigationController?.popViewController(animated: true)
        
        list.addCheckListItem(item)
        tableView.insertRows(at: [IndexPath(item: list.numberOfTasks - 1, section: 0)], with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        self.navigationController?.popViewController(animated: true)
        
        if let index = list.getIndex(for: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = list.get(at: indexPath.row).text
            }
        }
    }
}
