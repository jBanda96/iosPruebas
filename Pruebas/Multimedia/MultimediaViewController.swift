//
//  MultimediaViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 01/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import AVFoundation

class MultimediaViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    var playerViewController: VideoViewController?
    var player: AVAudioPlayer?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayerController" {
            self.playerViewController = segue.destination as? VideoViewController
            preparePlayerViewController()
        }
    }
    
    private func preparePlayerViewController() {
        if let playerVC = self.playerViewController {
            let itemPath = Bundle.main.path(forResource: "Video", ofType: "mp4")
            let itemURL = URL(fileURLWithPath: itemPath ?? "")
            playerVC.player = AVPlayer(url: itemURL)
        }
    }
    
    @IBAction func didClickOnPlayAudio(_ sender: UIButton) {
        
        if player == nil {
        
            let filePath = Bundle.main.path(forResource: "Song", ofType: "mp3")
            let fileURL = URL(fileURLWithPath: filePath ?? "")
            
            do {
                self.player = try AVAudioPlayer(contentsOf: fileURL)
                self.player?.play()
            } catch {
                print(error.localizedDescription)
            }
            
        } else if let player = player {
            if player.isPlaying {
                player.pause()
                playButton.setTitle("Play", for: .normal)
            }
        } else {
            player?.play()
            playButton.setTitle("Pause", for: .normal)
        }
        
    }

}
