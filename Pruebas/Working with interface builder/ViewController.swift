//
//  ViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 28/04/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        listenToKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unlistenToKeyboardNotification()
    }

    private func listenToKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        
    }
    
    private func unlistenToKeyboardNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWasShown(notification: NSNotification){
        if let info: Dictionary = notification.userInfo {
            
            if let keyboardSize = info[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                print(info[UIKeyboardFrameBeginUserInfoKey] ?? "Ningun valor")
                
                let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.size.height, 0.0)
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
                self.perform(#selector(scrollToBottom), with: nil, afterDelay: 0)
                
            }
            
        }
    }
    
    @objc private func scrollToBottom() {
        let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.height + self.scrollView.contentInset.bottom)
        self.scrollView.setContentOffset(offset, animated: true)
    }

}

