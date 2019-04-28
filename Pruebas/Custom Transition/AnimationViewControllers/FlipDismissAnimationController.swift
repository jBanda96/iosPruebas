//
//  FlipDismissAnimationController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/19/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class FlipDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let destinationFrame: CGRect
    let interactionController: SwipeInteractionController
    
    init(destinationFrame: CGRect, interactionController: SwipeInteractionController) {
        self.destinationFrame = destinationFrame
        self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else { return }
        
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
//        AnimationHelper.perspectiveTransform(for: containerView)
//        toVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)

        toVC.view.alpha = 0.0
        
        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    snapshot.frame = self.destinationFrame
                }

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2/3) {
                    //snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
                    snapshot.alpha = 0.0
                    toVC.view.alpha = 1.0
                }

//                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
//                    toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
//                }
        },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
