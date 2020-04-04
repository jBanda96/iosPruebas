//
//  DelegationViewController.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 3/27/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

// MARK: Object needing a Delegate
class DelegationViewController: UIViewController {

    @IBOutlet weak var table: UITableView! {
        didSet {
            table.delegate = self
            table.dataSource = self
            let delegate = ObjectActingAsDelegate()
            self.delegate = delegate
        }
    }
    
    var delegate: DelegationViewControllerDelegate?
    private var items = ["item 1", "item 2", "item 3"]
    
    func removeObject(at index: Int? = nil) {
        
        defer {
            let indexPath: IndexPath
            if let index = index {
                indexPath = IndexPath(row: index, section: 0)
            } else {
                indexPath = IndexPath(item: items.count - 1, section: 0)
            }
            
            table.deleteRows(at: [indexPath], with: .fade)
        }
        
        guard let index = index else {
            items.removeLast()
            return
        }
        
        if index < items.count {
            items.remove(at: index)
        }
    }
    
    deinit {
        print("\(String(describing: Self.self)) has deinitialized")
    }
}

extension DelegationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}

extension DelegationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.delegateViewController(self, didSelectItemAt: indexPath.row)
    }
}

// MARK: - Delegate
protocol DelegationViewControllerDelegate: class {
    func delegateViewController(_ viewController: DelegationViewController, didSelectItemAt index: Int)
}


// MARK: Object acting as a Delegate
class ObjectActingAsDelegate: DelegationViewControllerDelegate {
    func delegateViewController(_ viewController: DelegationViewController, didSelectItemAt index: Int) {
        viewController.removeObject(at: index)
    }
}
