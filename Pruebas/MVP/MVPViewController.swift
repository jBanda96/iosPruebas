//
//  MVPViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MVPViewController: UIViewController {
    
    @IBOutlet weak var vista : MainView!
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vista.likeAction = { self.like() }
        
        vista.button.setTitle(presenter.likedButtonTitle, for: .normal)
        self.vista.secondView.backgroundColor = self.presenter.color
        
    }
    
    func like() {
        presenter.updateLike()
        
        vista.button.setTitle(presenter.likedButtonTitle, for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.vista.secondView.backgroundColor = self.presenter.color
        }
        
    }
    
}
