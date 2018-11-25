//
//  TicTacToeViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 11/23/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    let X: String = "X"
    let O: String = "O"
    
    var ticTacToe: [[Int]] = [[0, 0], [0, 0], [0, 0], [1, 0], [1, 0], [1, 0], [2, 0], [2, 0], [2, 0]]
    
    var isX: Bool = false
    var turn:   Int     =       0   {
        didSet {
            isX = !isX
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touch(in button: UIButton){
        print(button.tag)
        
        for (index, _) in ticTacToe.enumerated() {
            if index == button.tag {
                ticTacToe[index][1] = 1
            }
        }
        
        for row in ticTacToe {
            for (index, column) in row.enumerated() {
                print("\(index) - \(column)")
            }
        }
        
        if button.titleLabel?.text == X || button.titleLabel?.text == O { return }
        
        turn += 1
        
        let boxValue: String    =   isX     ?   X     :       O
        button.setTitle(boxValue, for: .normal)
        
        if turn > 4 {
            
        }
        
    }
    
}
