//
//  CapturePhotosAndVideosViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 02/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import MobileCoreServices

class CapturePhotosAndVideosViewController: UIViewController {

    @IBAction func didClickOnPickButton(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: "Pick media",
                                                      message: "From where to you want to pick your photo or video",
                                                      preferredStyle: .actionSheet)
        
        let photosAction = UIAlertAction(title: "Photos",
                                         style: .default) { (action) in
            self.openPickerWithSourceType(.photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) { (action) in
            self.openPickerWithSourceType(.camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        actionSheetController.addAction(photosAction)
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    private func openPickerWithSourceType(_ type: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        imagePickerController.sourceType = type
        
        self.present(imagePickerController, animated: true, completion: nil)
    }

}

extension CapturePhotosAndVideosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        let type = info[UIImagePickerControllerMediaType] as! String
        
        if type == kUTTypeImage as String {
            print("Done picking image")
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        } else {
            print("Done picking a video")
            if let videoURL = info[UIImagePickerControllerMediaURL] {
                print(videoURL)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}















