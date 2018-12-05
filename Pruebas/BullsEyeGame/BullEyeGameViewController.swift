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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(orientation, forKey: "orientation")
        
        score = 0
        startNewRound()
    }
    
    @IBAction func sliderMoves (_ slider: UISlider) {
        print("The value of the slider is: \(slider.value)")
        
        let roundedValue: Float =   slider.value.rounded()
        currentValue            =   Int(roundedValue)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        let difference: Int =   abs(targetValue - currentValue)
        let points: Int      =   100 - difference
        score += points
        
        let message: String = "You scored: \(points) points \nscore: \(score)"
        
        let alert: UIAlertController    =   UIAlertController(title: "",
                                                              message: message,
                                                              preferredStyle: .alert)
        
        let action: UIAlertAction       =   UIAlertAction(title: "Ok",
                                                          style: .default) { (_) in
                                                                self.startNewRound()
                                                            }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    func startNewRound(){
        targetValue     =   makeNewTargetValue()
        currentValue    =   50
        slider.value    =   50.0
    }
    
    func makeNewTargetValue() -> Int {
        return Int.random(in: 0...100)
    }
    
    //MARK: - View Orientation
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}
