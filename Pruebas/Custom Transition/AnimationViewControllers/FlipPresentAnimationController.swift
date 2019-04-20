//
//  FlipPresentAnimationController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/19/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
        let toVC = transitionContext.viewController(forKey: .to),
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true) else { return }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = originFrame
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true

        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true

//        AnimationHelper.perspectiveTransform(for: containerView)
//        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        snapshot.alpha = 0.0

        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 2/3) {
                    //fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                    fromVC.view.alpha = 0.0
                    snapshot.alpha = 1.0
                }

                
//                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
//                    //snapshot.layer.transform = AnimationHelper.yRotation(0.0)
//                }

                
                UIView.addKeyframe(withRelativeStartTime: 4/6, relativeDuration: 1/6) {
                    snapshot.frame = finalFrame
                    snapshot.layer.cornerRadius = 75
                }
                
                UIView.addKeyframe(withRelativeStartTime: 5/6, relativeDuration: 1/6) {
                    snapshot.layer.cornerRadius = 0
                }
        },
            
            completion: { _ in
                toVC.view.isHidden = false
                snapshot.removeFromSuperview()
                //fromVC.view.layer.transform = CATransform3DIdentity
                fromVC.view.alpha = 1.0
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransform(for containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
