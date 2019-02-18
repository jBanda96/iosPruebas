/*
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class LargerScrollViewController: NoNavigationBarViewController {
    @IBOutlet weak var fgScrollView: UIScrollView!
    @IBOutlet weak var felipeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fgScrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        fgScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // animate the wings
        var animationFrames = [UIImage]()
        for i in 0...3 {
            if let image = UIImage(named: "SV_Bird\(i)") {
                animationFrames.append(image)
            }
        }
        
        felipeImageView.animationImages = animationFrames
        felipeImageView.animationDuration = 0.4
        felipeImageView.startAnimating()
    }
    
    @objc func adjustInsetForKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let show = notification.name == Notification.Name.UIKeyboardWillShow ? true : false
        let adjustmentHeight = keyboardFrame.height * (show ? 1 : -1)
        
        fgScrollView.contentInset.bottom += adjustmentHeight
        fgScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
        
    }
    
}

extension LargerScrollViewController: UIScrollViewDelegate {
}

extension LargerScrollViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
