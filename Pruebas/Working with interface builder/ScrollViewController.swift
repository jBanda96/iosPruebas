//
//  ScrollViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 16/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerForKeyboardNotifications()
        
    }
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(manageKeyboard(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(manageKeyboard(_:)), name: .UIKeyboardWillHide, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:))))
        
    }
    
    @objc func manageKeyboard(_ notification: NSNotification) {
        
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = notification.name == Notification.Name.UIKeyboardDidShow ? UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0) : UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        self.view.endEditing(true)
    }

}
