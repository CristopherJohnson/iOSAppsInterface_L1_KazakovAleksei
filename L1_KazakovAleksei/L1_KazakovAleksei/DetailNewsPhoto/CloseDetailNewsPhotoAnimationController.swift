//
//  CloseDetailNewsPhotoAnimationController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 02/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class CloseDetailNewsPhotoAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            print("start close Animation")
            if let sourceVC = source as? DetailNewsPhotoViewController, let imageCoord = sourceVC.imageCoord {
                print("image size \(imageCoord)")
                sourceVC.detailPhotoConstraintLeft?.constant   = imageCoord.origin.x
                sourceVC.detailPhotoConstraintTop?.constant    = imageCoord.origin.y
                sourceVC.detailPhotoConstraintWidth?.constant  = imageCoord.size.width
                sourceVC.detailPhotoConstraintHeight?.constant = imageCoord.size.height
                sourceVC.view.layoutIfNeeded()
            }
        }) { (finished: Bool) in
            source.removeFromParent()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
    
    

}
