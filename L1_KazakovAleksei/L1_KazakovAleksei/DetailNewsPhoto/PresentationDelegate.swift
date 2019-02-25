//
//  PresentationDelegate.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class PresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {

    let openAnimationController = OpenDetailNewsPhotoAnimationController()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.openAnimationController
    }
}
