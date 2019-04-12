//
//  MainTableTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MainTableTableViewController: UITableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mvcSegue" {
            let vc = segue.destination as! MVCViewController
            vc.person = ModelMVC(firstName: "Julio", surName: "Banda")
        } else if segue.identifier == "mvpSegue" {
            let vc = segue.destination as! MVPViewController
            vc.presenter = Presenter()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 31 {
            performSegue(withIdentifier: "mvcSegue", sender: nil)
        } else if indexPath.row == 32 {
            performSegue(withIdentifier: "mvpSegue", sender: nil)
        } else if indexPath.row == 34 {
            let notice = NoticeRouter.createModule()
            
            self.navigationController?.pushViewController(notice, animated: true)
        }
    }
    
}
