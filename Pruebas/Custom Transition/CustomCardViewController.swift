//
//  CustomCardViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/18/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class CustomCardViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var index: Int?
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = pet?.name
        cardView.layer.cornerRadius = 25.0
        cardView.layer.masksToBounds = true
        
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "custom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "custom" {
            let vc = segue.destination as! CustomDetailViewController
            vc.pet = pet
            vc.transitioningDelegate = self
        }
        
    }

}

extension CustomCardViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController(originFrame: cardView.frame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let detailVC = dismissed as? CustomDetailViewController else { return nil }
        
        return FlipDismissAnimationController(destinationFrame: cardView.frame, interactionController: detailVC.swipeInteractionController!)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            guard let animator = animator as? FlipDismissAnimationController,
                animator.interactionController.interactionInProgress
                else {
                    return nil
            }
            return animator.interactionController
    }
    
}
