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
        return 5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        var imageFrame: CGRect = CGRect.zero
        
//        if let feedViewController = source as? FeedViewController {
//            imageFrame = feedViewController.selectedImageFrame!
//        } else if let navigationVC = source as? UINavigationController,
//            let feedViewController = navigationVC.viewControllers.first as? FeedViewController {
//            imageFrame = feedViewController.selectedImageFrame!
//        }
        
        if let destVC = destination as? DetailNewsPhotoViewController {
            imageFrame = destVC.imageCoord!
        }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = imageFrame
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            destination.view.frame = source.view.bounds
        }) { (finished: Bool) in
            source.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
