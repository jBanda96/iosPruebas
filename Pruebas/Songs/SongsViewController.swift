//
//  SongsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 12/06/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SongsViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let download = SongDownload()
    let musicItem = MusicItem(id: 192678693,
                              artistName: "Leonard Cohen",
                              trackName: "Hallelujah",
                              collectionName: "The Essential Leonard Cohen",
                              preview: "https://audio-ssl.itunes.apple.com/itunes-assets/Music/16/10/b2/mzm.muynlhgk.aac.p.m4a",
                              artwork: "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/77/17/ab/7717ab31-46f9-48ca-7250-9f565306faa7/source/1000x1000bb.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlbumArt()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgress(_:)), name: .progress, object: nil)
    }
    
    @IBAction func requestSong(_ sender: UIButton) {
        
        let title = self.download.downloadLocation == nil ? "Downloading" : "Play"
        self.requestButton.setTitle(title, for: .normal)
        
        if self.download.downloadLocation == nil {
            guard let previewUrl = self.musicItem.previewUrl else {
                return
            }
            self.download.fetchSong(previewUrl)
        } else {
            let player = AudioPlayer(songUrl: self.download.downloadLocation!)
            self.present(player.makeUIViewController(), animated: true)
        }
        
    }

    @IBAction func cancelDownload(_ sender: Any) {
        self.download.cancelDownload()
        
        DispatchQueue.main.async {
            let title = "Download"
            self.requestButton.setTitle(title, for: .normal)
            
            self.progress.isHidden = true
            self.progressLabel.isHidden = true
            
            self.progress.progress = 0.0
            self.progressLabel.text = "0%"
        }
    }
    
    @IBAction func pauseDownload(_ sender: UIButton) {
        self.download.pauseDownload()
    }
    
    @IBAction func resume(_ sender: UIButton) {
        self.download.resumeDownload()
    }
    
    private func displayAlbumArt() {
        guard let albumArtUrl = URL(string: musicItem.artwork) else { return }
        let task = URLSession.shared.downloadTask(with: albumArtUrl) { location, response, error in
            guard let location = location,
                let imageData = try? Data(contentsOf: location),
                let image = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                self.albumArt.image = image
            }
        }
        
        task.resume()
    }
    
    @objc func updateProgress(_ notification: Notification) {
        if let progressValue = notification.userInfo?["progress"] as? Float {
            DispatchQueue.main.async {
                self.progress.isHidden = false
                self.progressLabel.isHidden = false
                
                self.progress.progress = progressValue
                self.progressLabel.text = "\(Int(progressValue * 100))%"
            }
        }
    }
    
}


extension Notification.Name {
    static let progress = Notification.Name("DidReceiveProgressValue")
}
