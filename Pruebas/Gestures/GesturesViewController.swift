//
//  GesturesViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 02/06/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import AVFoundation
import simd

class GesturesViewController: NoNavigationBarViewController {
    
    let chompPlayer = AVAudioPlayer(fileName: "chomp")
    let LaughPlayer = AVAudioPlayer(fileName: "hehehe")
    
    @IBOutlet var interactiveSubviews: [UIImageView]! {
        didSet {
            for subview in interactiveSubviews {
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                tapRecognizer.delegate = self
                subview.addGestureRecognizer(tapRecognizer)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else { return }
        
        let translation = recognizer.translation(in: view)
        recognizerView.center.x += translation.x
        recognizerView.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)

        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: view)
            let vectorToFinalPoint = CGPoint(x: velocity.x / 15, y: velocity.y / 15)
            let bounds = UIEdgeInsetsInsetRect(view.bounds, view.safeAreaInsets)
            var finalPoint = recognizerView.center
            finalPoint.x += vectorToFinalPoint.x
            finalPoint.y += vectorToFinalPoint.y
            finalPoint.x = min(max(finalPoint.x, bounds.minX), bounds.maxX)
            finalPoint.y = min(max(finalPoint.y, bounds.minY), bounds.maxY)
            
            let vectorToFinalPointLenght = (
                vectorToFinalPoint.x * vectorToFinalPoint.x
                + vectorToFinalPoint.y * vectorToFinalPoint.y
            ).squareRoot()
            
            UIView.animate(withDuration: TimeInterval(vectorToFinalPointLenght / 1800), delay: 0.0, options: .curveEaseOut, animations: {
                recognizerView.center = finalPoint
            })
            
        }
        
    }
    
    @IBAction func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let recognizerView = recognizer.view else { return }
        
        print("Pinch: \(recognizer.scale)")
        recognizerView.transform = recognizerView.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
        
    }
    
    @IBAction func handleRotate(_ recognizer: UIRotationGestureRecognizer) {
        guard let recognizerView = recognizer.view else { return }
        
        print("Rotation: \(recognizer.rotation)")
        recognizerView.transform = recognizerView.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
        
    }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        chompPlayer.play()
    }
    
}

extension GesturesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension AVAudioPlayer {
    convenience init(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "caf")!
        try! self.init(contentsOf: url)
        prepareToPlay()
    }
}
