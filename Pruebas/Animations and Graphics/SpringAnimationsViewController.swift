//
//  SpringAnimationsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 11/18/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class SpringAnimationsViewController: UIViewController {

    lazy var otherView: UIView = {
        let view = UIView()
            view.backgroundColor = .blue
            view.frame = CGRect(x: 0, y: 50, width: self.view.frame.width / 2, height: self.view.frame.height / 5)
        
        return view
    }()
    
    lazy var anotherView: UIView = {
        let view = UIView()
            view.backgroundColor = .yellow
            view.frame = CGRect(x: 0, y: 200, width: self.view.frame.width / 4, height: self.view.frame.height / 8)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(otherView)
        self.view.addSubview(anotherView)
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {
                        
                        UIView.setAnimationRepeatCount(Float.infinity)
                        UIView.setAnimationRepeatAutoreverses(true)
                        
                        self.otherView.transform = CGAffineTransform(translationX: 150, y: 25)
                        
        })
        
        UIView.animate(withDuration: 4,
                       animations: {
            
                        UIView.setAnimationRepeatCount(Float.infinity)
                        UIView.setAnimationRepeatAutoreverses(true)
                        
                        let transform           =   CGAffineTransform(rotationAngle: .pi / 2)
                        let transformations     =   transform.concatenating(CGAffineTransform(translationX: 250, y: 100).concatenating(CGAffineTransform(scaleX: 0.5, y: 2)).concatenating(.identity))
                        
                        self.anotherView.transform          =   transformations
                        self.anotherView.backgroundColor    =   .green
                        
        })
        
    }

}
