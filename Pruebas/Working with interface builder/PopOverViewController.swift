//
//  PopOverViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/21/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class PopOverViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        modalPresentationStyle = .popover
        popoverPresentationController?.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss(animated:completion:)))
        
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "SmallButton"))
        backgroundImage.contentMode = .center
        tableView.backgroundView = backgroundImage
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .compact):  return .fullScreen
        default:                    return .none
        }
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }

}
