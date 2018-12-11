//
//  BullEyeGameViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 12/2/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class BullEyeGameViewController: UIViewController {

    @IBOutlet weak var slider:      UISlider!
    @IBOutlet weak var scoreLabel:  UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel:  UILabel!
    
    var orientation = UIInterfaceOrientation.landscapeLeft.rawValue
    
    lazy var currentValue: Int  = {
        return Int(slider.value.rounded())
    }()
    var targetValue: Int        =   0 {
        willSet {
            targetLabel.text = String(describing: newValue)
        }
    }
    var score: Int              =   0 {
        willSet {
            scoreLabel.text = String(describing: newValue)
        }
    }
    var round: Int              =   0 {
        willSet {
            roundLabel.text = String(describing: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(orientation, forKey: "orientation")
        startNewGame()
    }
    
    @IBAction func sliderMoves (_ slider: UISlider) {
        print("The value of the slider is: \(slider.value)")
        
        let roundedValue: Float =   slider.value.rounded()
        currentValue            =   Int(roundedValue)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        let difference: Int =   abs(targetValue - currentValue)
        var points: Int      =   100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close"
        }
        
        let message: String = "You scored: \(points) points."
        
        let alert: UIAlertController    =   UIAlertController(title: title,
                                                              message: message,
                                                              preferredStyle: .alert)
        
        let action: UIAlertAction       =   UIAlertAction(title: "Ok",
                                                          style: .default) { (_) in
                                                                self.score += points
                                                                self.startNewRound()
                                                            }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
    }
    
    func startNewRound(){
        round += 1
        
        targetValue     =   makeNewTargetValue()
        
        currentValue    =   50
        slider.value    =   50.0
    }
    
    func makeNewTargetValue() -> Int {
        return Int.random(in: 0...100)
    }
    
    func startNewGame(){
        self.score = 0
        self.round = 0
        
        self.startNewRound()
    }

    
    //MARK: - View Orientation
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}
