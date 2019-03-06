//
//  OpenDetailNewsPhotoAnimationController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class OpenDetailNewsPhotoAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = transitionContext.containerView.bounds
        
        if let destVC = destination as? DetailNewsPhotoViewController, let imageCoord = destVC.imageCoord {
            
            destVC.detailPhotoConstraintLeft?.constant   = imageCoord.origin.x
            destVC.detailPhotoConstraintTop?.constant    = imageCoord.origin.y
            destVC.detailPhotoConstraintWidth?.constant  = imageCoord.size.width
            destVC.detailPhotoConstraintHeight?.constant = imageCoord.size.height
            
            destVC.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            if let destVC = destination as? DetailNewsPhotoViewController {
                
                destVC.detailPhotoConstraintLeft?.constant   = 0
                destVC.detailPhotoConstraintTop?.constant    = 0
                destVC.detailPhotoConstraintWidth?.constant  = transitionContext.containerView.frame.size.width
                destVC.detailPhotoConstraintHeight?.constant = transitionContext.containerView.frame.size.height
                destVC.view.layoutIfNeeded()
            }
            
        }) { (finished: Bool) in
            //source.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
