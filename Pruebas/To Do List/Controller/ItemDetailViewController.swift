//
//  AddItemController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/2/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}


class ItemDetailViewController: UITableViewController {
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    weak var todoList: TodoList?
    weak var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        
        if let itemToEdit = itemToEdit {
            self.taskTextField.text = itemToEdit.text
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        if let item = itemToEdit, let text = taskTextField.text {
            item.text = text
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
        } else {
            let taskName: String = taskTextField.text ?? "No name assigned"
            let task = ChecklistItem(text: taskName, priority: .low)
            
            delegate?.itemDetailViewController(self, didFinishAdding: task)}
    }
    
    func setupNavigationController(){
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    deinit {
        print("The AddItemController has been deleted")
    }
    
}

extension ItemDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
