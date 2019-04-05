//
//  MVVMViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/4/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class MVVMViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    var viewModel: GreetingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GreetingViewModel(person: Person3(firstName: "Julio", lastName: "Banda"))
        greetingLabel.text = viewModel.greet()
        
        configureTap()
        
    }
    
    func configureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tap.numberOfTapsRequired = 2
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        viewModel.name = "Luis"
        greetingLabel.text = viewModel.greet()
    }
    
}
