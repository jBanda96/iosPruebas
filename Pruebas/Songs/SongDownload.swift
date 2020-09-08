//
//  SongDownload.swift
//  Pruebas
//
//  Created by Julio Banda on 12/06/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
class SongDownload: NSObject {
    
    var downloadTask: URLSessionDownloadTask?
    var downloadUrl: URL?
    
    var downloadLocation: URL?
    var downloadedAmount: Float = 0
    var isDownloading: Bool = false
    
    var data: Data?
    
    lazy var urlSession: URLSession = {
        URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }()
    
    func fetchSong(_ item: URL) {
        downloadUrl = item
        downloadTask = urlSession.downloadTask(with: item)
        downloadTask?.resume()
        isDownloading = true
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
    }
    
    func pauseDownload() {
        downloadTask?.cancel(byProducingResumeData: { data in
            self.data = data
        })
    }
    
    func resumeDownload() {
        guard let resumeData = self.data else { return }
        downloadTask = self.urlSession.downloadTask(withResumeData: resumeData)
        downloadTask?.resume()
    }
    
}


@available(iOS 13.0, *)
extension SongDownload: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let fileManager = FileManager.default
        guard let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
            let lastPathComponent = downloadUrl?.lastPathComponent else { fatalError() }
        
        let destinationUrl = documentsPath.appendingPathComponent(lastPathComponent)
        
        do {
            if fileManager.fileExists(atPath: destinationUrl.path) {
                try fileManager.removeItem(at: destinationUrl)
            }
            try fileManager.copyItem(at: location, to: destinationUrl)
            
            DispatchQueue.main.async {
                self.downloadLocation = destinationUrl
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        self.downloadedAmount = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
        NotificationCenter.default.post(name: .progress, object: nil, userInfo: ["progress": downloadedAmount])
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
}
