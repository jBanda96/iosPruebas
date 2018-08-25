//
//  MusicViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 24/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    @IBOutlet weak var albumImageView: UIView!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playPauseBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            } else {
                playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        animateAlbumImage()
    }
    
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
            
        case playPauseButton:
            buttonBackground = playPauseBackground
            
        case forwardButton:
            buttonBackground = forwardBackground
            
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
            case reverseButton:
            buttonBackground = reverseBackground
            
            case playPauseButton:
            buttonBackground = playPauseBackground
            
            case forwardButton:
            buttonBackground = forwardBackground
            
            default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            buttonBackground.alpha = 0
            sender.transform = CGAffineTransform.identity
            
        }) { (_) in
            buttonBackground.transform = CGAffineTransform.identity
        }
        
    }
    
    private func animateAlbumImage() {
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform.identity
            }
        }
        isPlaying = !isPlaying
    }

}
