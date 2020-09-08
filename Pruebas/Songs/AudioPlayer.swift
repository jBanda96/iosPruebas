//
//  AudioPlayer.swift
//  Pruebas
//
//  Created by Julio Banda on 12/06/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation
import AVKit

struct AudioPlayer {
  
  func makeUIViewController() -> AVPlayerViewController {
    let player = AVPlayer(url: songUrl)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    playerViewController.entersFullScreenWhenPlaybackBegins = true
    playerViewController.player?.play()
    return playerViewController
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController) {
    
  }
  
  let songUrl: URL
  
}
