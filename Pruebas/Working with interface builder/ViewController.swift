//
//  ViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 28/04/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class ViewController: NoNavigationBarViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        updateZoomForSize(self.view.bounds.size)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func updateZoomForSize(_ size: CGSize) {
        
        let widthScale = size.width / image.bounds.width
        let heightScale = size.height / image.bounds.height
        let scale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = scale
        
    }

}

