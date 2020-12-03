//
//  TestCell.swift
//  Pruebas
//
//  Created by Julio Banda on 28/09/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit
import LATAMDeviceSDK

class TestCell: UITableViewCell {
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var testStatusImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func populate(with test: Test) {
        testImage.image = UIImage(named: self.getImage(for: test.type))
        testName.text = test.name
        self.showIndicatorOrImage(in: test.status)
    }
    
    private func getImage(for type: LTDSDKHealthCheckType) -> String {
        switch type {
        case .Sensor:
            return "sensor"
        case .Display:
            return "display"
        case .Speaker:
            return "speaker"
        case .Mic:
            return "mic"
        case .BT:
            return "bt"
        case .Battery:
            return "battery"
        case .FrontCamera:
            return "front"
        case .BackCamera:
            return "back"
        }
    }
    
    private func showIndicatorOrImage(in status: Test.Status) {
        testStatusImage.isHidden = true
        switch status {
        case .passed:
            testStatusImage.image = showSuccessImage()
        case .failed:
            testStatusImage.image = showErrorImage()
        case .onCourse:
            showLoadingView()
        case .notStartedYet:
            return
        }
    }
    
    private func showSuccessImage() -> UIImage? {
        indicator.stopAnimating()
        testStatusImage.isHidden = false
        return UIImage(named: "bien")
    }
    
    private func showErrorImage() -> UIImage? {
        indicator.stopAnimating()
        testStatusImage.isHidden = false
        return UIImage(named: "mal")
    }
    
    private func showLoadingView() {
        testStatusImage.isHidden = true
        indicator.startAnimating()
    }

}
