//
//  Scanner.swift
//  Pruebas
//
//  Created by Julio Banda on 28/01/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import AVFoundation

class Scanner: NSObject {
    
    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
    
    func readQr(from image: UIImage) -> String {
        let qr = CIImage(image: image)
        let features = detector?.features(in: qr!) as! [CIQRCodeFeature]
        
        var string = ""
        for feature in features {
            string += feature.messageString!
        }
        
        return string
    } 
    
}
