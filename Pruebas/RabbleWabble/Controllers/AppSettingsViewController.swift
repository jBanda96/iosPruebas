//
//  AppSettingsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 8/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class AppSettingsViewController: UITableViewController {

    // MARK: Properties
    public let appSettings = AppSettings.shared
    private let cellIdentifier = "basicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

}

// MARK: UITableViewDataSource
extension AppSettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let questionStrategy = QuestionStrategyType.allCases[indexPath.row]
        cell.textLabel?.text = questionStrategy.title()
        
        if appSettings.questionStrategyType == questionStrategy {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension AppSettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}
