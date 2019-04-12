//
//  NoticeViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var notices = [NoticeModel]()
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Notice-Module"
        presenter?.startFetchingNotice()
    }

}


extension NoticeViewController: PresenterToViewProtocol {
    func showNotice(noticeArray: Array<NoticeModel>) {
        self.notices = noticeArray
        self.tableView.reloadData()
    }
    
    func showError() {
        
    }
}


extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeCell
        cell.id.text            =   notices[indexPath.row].id
        cell.name.text          =   notices[indexPath.row].title
        cell.brief.text         =   notices[indexPath.row].brief
        cell.fileSource.text    =   notices[indexPath.row].filesource
        
        return cell
    }
    
}


extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.router?.pushToMovieScreen(navigationController: self.navigationController!)
    }
    
}



class NoticeCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var brief: UILabel!
    @IBOutlet weak var fileSource: UILabel!
    
}
