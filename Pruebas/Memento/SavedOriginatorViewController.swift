//
//  SavedViewController.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 4/3/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

protocol SavedProtocol {
    func didSelectSaved(_ viewController: SavedOriginatorsViewController?, originator: Originator?)
}

class SavedOriginatorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var delegate: SavedProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CareTaker.shared.all?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = CareTaker.shared.all?[indexPath.row]?.state.first
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectSaved(self, originator: CareTaker.shared.all?[indexPath.row])
        }
    }
    
}
