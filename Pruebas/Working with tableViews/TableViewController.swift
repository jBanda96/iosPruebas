//
//  TableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 30/04/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentCreateAction: UIAlertAction!
    
    var isEditingMode: Bool = false
    
    let cellIdentifier: String = "autoresizingCell"
    var texts = [Text(string: "This is very simple text"),
                 Text(string: "Long text goes here, Long text goes here, Long text goes here"),
                 Text(string: "Some text goes here Some text goes here Some text goes here Some text goes here Some text goes here"),
                 Text(string: "Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here Very looooooooooooong text goes here")]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    @IBAction func clickOnAddButton(_ sender: UIBarButtonItem) {
        let title = "New text"
        let doneTitle = "Create"
        
        let alertController = UIAlertController(title: title, message: "Write something", preferredStyle: .alert)
        let createAction = UIAlertAction(title: doneTitle, style: .default) { (action) in
            
            let stringName = alertController.textFields?.first?.text
            let newString = Text(string: stringName!)
            
            self.texts.append(newString)
            
            self.tableView.insertRows(at: [IndexPath(row: self.texts.count - 1, section: 0)], with: .fade)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        createAction.isEnabled = true
        
        self.currentCreateAction = createAction
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Text"
            //textfield.addTarget(self, action: #selector(ViewController.taskNameFieldDidChange(textfield:)), for: .editingChanged)
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func clickOnEditButton(_ sender: UIBarButtonItem) {
        isEditingMode = !isEditingMode
        self.tableView.setEditing(isEditingMode, animated: true)
    }

}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            
            self.texts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let copyAction = UITableViewRowAction(style: .normal, title: "Copy") { (copyAction, indexPath) in
            let text = self.texts[indexPath.row]
            self.texts.append(text)
            
            tableView.insertRows(at: [IndexPath(item: self.texts.count - 1, section: 0)], with: UITableViewRowAnimation.middle)
            
        }
        
        return [deleteAction, copyAction]
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let textToMove = self.texts[sourceIndexPath.row]
        self.texts.remove(at: sourceIndexPath.row)
        self.texts.insert(textToMove, at: destinationIndexPath.row)
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let text = texts[indexPath.row]
        
        cell.textLabel?.text = text.string
        cell.showsReorderControl = true
        
        return cell
    }
    
}

