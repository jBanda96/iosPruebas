//
//  SwipeInteractionController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/20/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    private var shouldCompleteTransition:   Bool = false
    var interactionInProgress:              Bool = false
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        self.prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handeGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!.superview!)
        var progress = translation.x / 200
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gesture.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
    
}
