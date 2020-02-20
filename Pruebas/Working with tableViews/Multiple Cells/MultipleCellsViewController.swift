//
//  MultipleCellsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 17/12/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MultipleCellsViewController: NoNavigationBarViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    fileprivate func configureTableView() {
        self.registerCells(in: self.tableView)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    fileprivate func registerCells(in tableView: UITableView) {
        tableView.register(UINib(nibName: String.init(describing: ImageCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ImageCell.self))
        tableView.register(UINib(nibName: String.init(describing: BodyCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: BodyCell.self))
    }
    
    @IBAction func share(_ button: UIButton) {
        let shareController = UIActivityViewController(activityItems: [UIImage(named: "gg")!], applicationActivities: nil)
        self.present(shareController, animated: true)
    }
    
}

extension MultipleCellsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - TableView Data Source
extension MultipleCellsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ImageCell.self), for: indexPath) as! ImageCell
            cell.imageView?.image = #imageLiteral(resourceName: "logo")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: BodyCell.self), for: indexPath) as! BodyCell
            cell.mainLabel.text = "Ya puedes registrarte y usar CoDi®"
            cell.secondaryLabel.text = "El nuevo sistema de pagos y cobros con celular del Banco de México ya está disponible en tu aplicación. CoDi® no genera comisiones. Monto máximo por operación $8,000 M.N."
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
}
