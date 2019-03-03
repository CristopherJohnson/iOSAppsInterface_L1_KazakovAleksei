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
        if let sourceVC = source as? DetailNewsPhotoViewController {

            let imageViewSizeOptional = sourceVC.detailPhoto?.frame.size
            let size = sourceVC.detailPhoto?.image?.size
            
            guard let imageSize = size else { return }
            guard let imageViewSize = imageViewSizeOptional else { return }
            
            let scaleWidth = imageViewSize.width / imageSize.width
            let scaleHiegh = imageViewSize.height / imageSize.height
            let aspect = fmin(scaleWidth, scaleHiegh)
            
            var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
            
            imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
            imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
            imageRect.origin.x += (sourceVC.detailPhoto?.frame.origin.x)!
            imageRect.origin.y += (sourceVC.detailPhoto?.frame.origin.y)!
            
            sourceVC.detailPhoto?.frame = imageRect
            sourceVC.detailPhoto?.contentMode = UIView.ContentMode.scaleAspectFill
            sourceVC.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            print("start close Animation")
            if let sourceVC = source as? DetailNewsPhotoViewController, let imageCoord = sourceVC.imageCoord {
                print("image size \(imageCoord)")
                
                sourceVC.detailPhotoConstraintLeft?.constant   = imageCoord.origin.x
                sourceVC.detailPhotoConstraintTop?.constant    = imageCoord.origin.y
                sourceVC.detailPhotoConstraintWidth?.constant  = imageCoord.size.width
                sourceVC.detailPhotoConstraintHeight?.constant = imageCoord.size.height
//                sourceVC.detailPhoto?.contentMode = UIView.ContentMode.scaleAspectFill
//                sourceVC.detailPhoto?.clipsToBounds = true
                sourceVC.view.layoutIfNeeded()
            }
        }) { (finished: Bool) in
            source.removeFromParent()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
    
    

}
