//
//  PiratesViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/20/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class PiratesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = [#imageLiteral(resourceName: "weather-sun"), #imageLiteral(resourceName: "weather-windy"), #imageLiteral(resourceName: "weather-thunderstorm")]
        
        let imageViews: [UIImageView] = images.map {
            let imageView = UIImageView(image: $0)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
        
        let spacerGuide     =   (0..<images.count - 1).map { _ in UILayoutGuide() }
        
        imageViews.forEach( view.addSubview )
        spacerGuide.forEach( view.addLayoutGuide )
        
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: """
                                            |[leftGap]\
                                            -[monday(fullWidth@849)]-(bigGap)\
                                            -[tuesday(smaller@849)]-(gap)-[wednesday(smaller@849)]\
                                            -(gap)-[rightGap(==leftGap)]|
                                            """,
                                           options: .alignAllBottom,
                                           metrics: {
                                            let imageWidth = imageViews[0].image!.size.width
                                            let gap: CGFloat = 8
                                            return [
                                                "fullWidth": imageWidth,
                                                "smaller": imageWidth * 0.7,
                                                "bigGap": gap * 3,
                                                "gap": gap
                                            ]
            }(),
                                           views: Dictionary(uniqueKeysWithValues: [
                                            (["monday", "tuesday", "wednesday"], imageViews),
                                            (["leftGap", "rightGap"], spacerGuide)
                                            ].flatMap { (keys, values: [Any]) in zip(keys, values) }
                )
                )
                + [imageViews[0].centerYAnchor.constraint(equalTo: view.centerYAnchor)]
                + imageViews.map { $0.heightAnchor.constraint(equalTo: $0.widthAnchor) }
        )
        
    }
    
}
