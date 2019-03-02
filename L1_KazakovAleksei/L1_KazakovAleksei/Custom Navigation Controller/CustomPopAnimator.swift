//
//  CustomPopAnimator.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = source.view.frame
        let frame = source.view.frame
        
//        let translation = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        let rotation = CGAffineTransform(rotationAngle: -.pi / 2)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            source.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            source.view.frame = frame
            
            source.view.transform = rotation
        }) { (finished: Bool) in
            
            if finished && !transitionContext.transitionWasCancelled {
                source.view.removeFromSuperview()
            } else if transitionContext.transitionWasCancelled {
                source.view.transform = CGAffineTransform.identity
            }

            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
        
    }
}
