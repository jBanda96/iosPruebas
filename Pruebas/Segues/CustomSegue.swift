//
//  CustomSegue.swift
//  Pruebas
//
//  Created by Julio Banda on 01/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {

        if let fromView = self.source.view, let toView = self.destination.view {
            
            var frame = toView.frame
            let screenHeight = UIScreen.main.bounds.size.height
            let screenWidht = UIScreen.main.bounds.size.width
            
            frame.size = CGSize(width: 2 * screenWidht / 3, height: screenHeight / 2)
            toView.frame = frame
            
            if let window = UIApplication.shared.keyWindow {
                toView.center = window.center
                window.insertSubview(toView, aboveSubview: fromView)
                toView.transform = CGAffineTransform(scaleX: 0, y: 0)
                
                UIView.animate(withDuration: 0.5) {
                    toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
            
        }
        
    }
    
}
