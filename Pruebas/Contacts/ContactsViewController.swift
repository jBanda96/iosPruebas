//
//  ContactsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 27/01/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var qrLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentContactsPicker(_ sender: UIButton) {
        let contactsPicker = CNContactPickerViewController()
        contactsPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactsPicker.delegate = self
        self.present(contactsPicker, animated: true)
    }
    
    @IBAction func presentImagePicker(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
}

// MARK: - Contact Picker
extension ContactsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        if  let phoneNumber = contactProperty.value as? CNPhoneNumber, 
            var validPhoneNumber = phoneNumber.value(forKey: "digits") as? String {
            if validPhoneNumber.count > 10 {
                let index = validPhoneNumber.index(validPhoneNumber.endIndex, offsetBy: -10)
                validPhoneNumber = String(validPhoneNumber[index...])
            }
            UIView.animate(withDuration: 2) { 
                self.phoneNumberLabel.isHidden = false
            }
            self.phoneNumberLabel.text = validPhoneNumber
        }
    }
}

// MARK: - Image Picker
extension ContactsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            qrLabel.text = Scanner().readQr(from: image)
            qrLabel.isHidden = false
            picker.dismiss(animated: true)
        }
    }
}
