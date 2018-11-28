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
    
    var game: [[String]]   =    [["", "", ""],
                                 ["", "", ""],
                                 ["", "", ""]]
    
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

        if button.titleLabel?.text == X || button.titleLabel?.text == O { return }
        
        let tag:    String       =       String(button.tag)
        let row:    Int          =       Int(String(tag.first!))! - 1
        let column: Int          =       Int(String(tag.last!))!  - 1
        
        turn += 1
        
        let boxValue: String    =   isX     ?   X     :       O
        
        button.setTitle(boxValue, for: .normal)
        game[row][column] = boxValue
        
        if turn > 2 {
            for row in 0 ..< game.count {
                
                if (game[row][1] == game[row][0]) && (game[row][1] == game[row][2]) {
                    print("Alguien ganó")
                }
                
            }
        }
        
    }
    
}
