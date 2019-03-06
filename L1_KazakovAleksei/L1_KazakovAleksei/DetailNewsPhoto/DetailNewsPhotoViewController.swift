//
//  DetailNewsPhotoViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class DetailNewsPhotoViewController: UIViewController {
    
    var allPhotoesNames:[String] = []
    
    var selectedPhotoIndex: Int = 0
    
    var imageCoord: CGRect?
    
    var fromView: UIView?
    
    private let scaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    @IBOutlet weak var detailPhoto: UIImageView?
    @IBOutlet weak var infoLable: UILabel?
    
    @IBOutlet weak var detailPhotoConstraintLeft:   NSLayoutConstraint?
    @IBOutlet weak var detailPhotoConstraintTop:    NSLayoutConstraint?
    @IBOutlet weak var detailPhotoConstraintWidth:  NSLayoutConstraint?
    @IBOutlet weak var detailPhotoConstraintHeight: NSLayoutConstraint?
    
    let presentationDelegate = PresentationDelegate()
    
    private var swipeLeftInteractiveAnimator:  UIViewPropertyAnimator?
    private var swipeRightInteractiveAnimator: UIViewPropertyAnimator?
    
    @IBOutlet weak var leftSideImageView: UIImageView?
    @IBOutlet weak var rigthSideImageView: UIImageView?
    
    private var startPoint: CGPoint = CGPoint.zero
    private var translation: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
        self.infoLable?.text = "Selected index: \(selectedPhotoIndex), count \(allPhotoesNames.count)"
        self.detailPhoto?.isUserInteractionEnabled = true
        self.detailPhoto?.contentMode = UIView.ContentMode.scaleAspectFit
        self.detailPhoto?.backgroundColor = UIColor.white
        self.detailPhoto?.clipsToBounds = true
        
        self.leftSideImageView?.isHidden = true
        self.rigthSideImageView?.isHidden = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        self.detailPhoto?.addGestureRecognizer(panGesture)
        
        swipeObserves()
    }
    
    
    //MARK: - Swipe
    
    @objc func swipeGestoreRecogniser (swipe: UISwipeGestureRecognizer) {
        
        switch swipe.direction {
//        case .right:
//
//            guard selectedPhotoIndex > 0 else {
//                break
//            }
//
//
//            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//                    self.detailPhoto?.transform = self.scaleTransform
//                })
//                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                    UIView.transition(with: self.detailPhoto!, duration: 0.15, options: .transitionFlipFromLeft, animations: {
//                        self.selectedPhotoIndex -= 1
//                        self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
//                        self.detailPhoto?.transform = CGAffineTransform.identity
//                    }, completion: nil)
//                })
//            }) { (finished: Bool) in
//                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"
//            }
//
////            selectedPhotoIndex -= 1
////            self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
//
//            print("right swipe")
//        case .left:
//
//            guard selectedPhotoIndex < (allPhotoesNames.count - 1) else {
//                break
//            }
//
//            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//                    self.detailPhoto?.transform = self.scaleTransform
//                })
//                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                    UIView.transition(with: self.detailPhoto!, duration: 0.15, options: .transitionFlipFromRight, animations: {
//                        self.selectedPhotoIndex += 1
//                        self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
//                        self.detailPhoto?.transform = CGAffineTransform.identity
//                    }, completion: nil)
//                })
//            }) { (finished: Bool) in
//                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"
//            }
//
////            selectedPhotoIndex += 1
////            self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
////
//            print("left swipe")
        case .up:
            self.transitioningDelegate = self.presentationDelegate
            self.dismiss(animated: true, completion: nil)
            
            print("up swipe")
        default:
            break
        }
        
    }
    
    private func swipeObserves (){
        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
//        swipeRight.direction = .right
//        self.detailPhoto?.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
//        swipeLeft.direction = .left
//        self.detailPhoto?.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
        swipeUp.direction = .up
        self.detailPhoto?.addGestureRecognizer(swipeUp)
        
    }

    //MARK: - pan gesture
    
    // Нужно решить проблему с закрытием детального просмотра фотографий
    
    private func setSize() {
        self.leftSideImageView?.frame = CGRect(x: -(self.detailPhoto?.frame.size.width)!, y: 0, width: (self.detailPhoto?.frame.size.width)!, height: (self.detailPhoto?.frame.size.height)!)
        self.rigthSideImageView?.frame = CGRect(x: (self.detailPhoto?.frame.size.width)!, y: 0, width: (self.detailPhoto?.frame.size.width)!, height: (self.detailPhoto?.frame.size.height)!)
        self.leftSideImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.rigthSideImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.bringSubviewToFront(self.leftSideImageView!)
        self.view.bringSubviewToFront(self.rigthSideImageView!)
    }

    @objc func panGesture (_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            
            self.setSize()
            
            startPoint = recognizer.location(in: self.detailPhoto?.superview)
            
            UIView.animate(withDuration: 0.1) {
                self.detailPhoto?.transform = self.scaleTransform
            }

            if selectedPhotoIndex < (allPhotoesNames.count - 1) {
                self.rigthSideImageView?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex + 1])
                self.rigthSideImageView?.isHidden = false
            }

            if selectedPhotoIndex > 0 {
                self.leftSideImageView?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex - 1])
                self.leftSideImageView?.isHidden = false
            }

            self.swipeLeftInteractiveAnimator?.startAnimation()
            self.swipeLeftInteractiveAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
                self.rigthSideImageView?.transform = CGAffineTransform(translationX: -(self.detailPhoto?.frame.size.width)!, y: 0)
            })
            self.swipeLeftInteractiveAnimator?.pauseAnimation()

            self.swipeRightInteractiveAnimator?.startAnimation()
            self.swipeRightInteractiveAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
                self.leftSideImageView?.transform = CGAffineTransform(translationX: (self.detailPhoto?.frame.size.width)!, y: 0)
            })
            swipeRightInteractiveAnimator?.pauseAnimation()

            
            
        case .changed:
            translation = recognizer.location(in: self.detailPhoto?.superview)
            print("pan changed")
            print("translation \(translation), startpoint \(startPoint)")
            if translation.x < startPoint.x {
                guard selectedPhotoIndex < (allPhotoesNames.count - 1) else {
                    break
                }
                print("swipeLeftInteractiveAnimator")
//                self.rigthSideImageView?.transform = CGAffineTransform(translationX: -(startPoint.x - translation.x), y: 0)
//
                self.swipeLeftInteractiveAnimator?.fractionComplete = (startPoint.x - translation.x) / (self.detailPhoto?.frame.size.width)!
            } else if translation.x > startPoint.x {
                guard selectedPhotoIndex > 0 else {
                    break
                }
                print("swipeRightInteractiveAnimator")
                self.swipeRightInteractiveAnimator?.fractionComplete = translation.x / (self.detailPhoto?.frame.size.width)!
            }
        case .ended:
            print("pan ended")
            print("translation \(translation), startpoint \(startPoint)")
            if translation.x < startPoint.x {
               
                print("swipeLeftInteractiveAnimator ended")
                self.swipeRightInteractiveAnimator?.stopAnimation(true)
                self.swipeLeftInteractiveAnimator?.stopAnimation(true)
                self.detailPhoto?.transform = CGAffineTransform.identity
                self.rigthSideImageView?.transform = CGAffineTransform.identity
                self.rigthSideImageView?.isHidden = true
                guard selectedPhotoIndex < (allPhotoesNames.count - 1) else {
                    break
                }
                self.selectedPhotoIndex += 1
                self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"
                
            } else if translation.x > startPoint.x {
                print("swipeRightInteractiveAnimator ended")
                self.swipeLeftInteractiveAnimator?.stopAnimation(true)
                self.swipeRightInteractiveAnimator?.stopAnimation(true)
                self.detailPhoto?.transform = CGAffineTransform.identity
                self.leftSideImageView?.isHidden = true
                self.leftSideImageView?.transform = CGAffineTransform.identity
                guard selectedPhotoIndex > 0 else {
                    break
                }
                self.selectedPhotoIndex -= 1
                self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"

            }
            
        default:
            return
        }
    }
    
    deinit {
        self.swipeLeftInteractiveAnimator?.stopAnimation(true)
        self.swipeRightInteractiveAnimator?.stopAnimation(true)
    }

}
