//
//  LongPressViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 07/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class LongPressViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }
    
    let iconsContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "angry")]
        let colors: [UIColor] = [.red, .blue, .orange, .yellow, .yellow, .green]
        let arrangedSubviews = images.map({ (image) -> UIView in
            let view = UIImageView(image: image)
            view.isUserInteractionEnabled = true
            view.layer.cornerRadius = iconHeight / 2
            
            return view
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        
        stackView.layoutMargins = UIEdgeInsetsMake(padding, padding, padding, padding)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.isLayoutMarginsRelativeArrangement = true
        
        container.addSubview(stackView)
        
        let icons = CGFloat(arrangedSubviews.count)
        let width = icons * iconHeight + (icons + 1) * padding
        
        container.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        container.layer.cornerRadius = container.frame.height / 2
        
        // Shadow
        container.layer.shadowColor = UIColor.init(white: 0, alpha: 1).cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowRadius = 8
        container.layer.shadowOffset = CGSize(width: 0, height: 12)
        
        stackView.frame = container.frame
        
        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLongPressGesture()
    }
    
    private func setupLongPressGesture() {
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        longGesture.minimumPressDuration = 0.5
        
        self.view.addGestureRecognizer(longGesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            handleBeginOf(gesture)
            
        } else if(gesture.state == .ended) {
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.iconsContainerView.alpha = 0
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: self.iconsContainerView.frame.height)
                
            }, completion: { (_) in
                self.iconsContainerView.alpha = 1
                self.iconsContainerView.removeFromSuperview()
            })
        
        } else if gesture.state == .changed {
            handleGestureChanged(gesture)
        }
        
    }
    
    
    fileprivate func handleGestureChanged(_ gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.iconsContainerView.frame.height / 2)
        
        let hitTest = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        if hitTest is UIImageView {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                hitTest?.transform = CGAffineTransform(translationX: 0, y: -50)
            }, completion: nil)
        }
        
        
    }
    
    fileprivate func handleBeginOf(_ gesture: UILongPressGestureRecognizer) {
        self.view.addSubview(iconsContainerView)
        
        let pressLocation = gesture.location(in: self.view)
        
        // Transformation of view
        let centerX = (self.view.frame.width - iconsContainerView.frame.width) / 2
        iconsContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y - 50)
        
        // Alpha
        iconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y - self.iconsContainerView.frame.height)
        })
    }
    

}
