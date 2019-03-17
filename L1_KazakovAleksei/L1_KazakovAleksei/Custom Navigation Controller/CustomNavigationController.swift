//
//  CustomNavigationController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate = self
        
        print("CustomNavigationController viewDidLoad")

        // Do any additional setup after loading the view.
    }
    let interactiveTransition = CustomInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            print("animation push")
            self.interactiveTransition.viewController = toVC
            print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
            return CustomPushAnomator()
        } else if operation == .pop {
            print("animation pop")
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
            return CustomPopAnimator()
        }
        return nil
    }
    
    

}
