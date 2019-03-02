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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
        self.infoLable?.text = "Selected index: \(selectedPhotoIndex), count \(allPhotoesNames.count)"
        self.detailPhoto?.isUserInteractionEnabled = true
        
        self.detailPhoto?.contentMode = UIView.ContentMode.scaleAspectFit
        self.detailPhoto?.backgroundColor = UIColor.white
        self.detailPhoto?.clipsToBounds = true
        
        swipeObserves()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func swipeGestoreRecogniser (swipe: UISwipeGestureRecognizer) {
        
        switch swipe.direction {
        case .right:
            
            guard selectedPhotoIndex > 0 else {
                break
            }
            
            
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.detailPhoto?.transform = self.scaleTransform
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    UIView.transition(with: self.detailPhoto!, duration: 0.15, options: .transitionFlipFromLeft, animations: {
                        self.selectedPhotoIndex -= 1
                        self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
                        self.detailPhoto?.transform = CGAffineTransform.identity
                    }, completion: nil)
                })
            }) { (finished: Bool) in
                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"
            }
            
//            selectedPhotoIndex -= 1
//            self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
            
            print("right swipe")
        case .left:
            
            guard selectedPhotoIndex < (allPhotoesNames.count - 1) else {
                break
            }
            
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.detailPhoto?.transform = self.scaleTransform
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    UIView.transition(with: self.detailPhoto!, duration: 0.15, options: .transitionFlipFromRight, animations: {
                        self.selectedPhotoIndex += 1
                        self.detailPhoto?.image = UIImage(named: self.allPhotoesNames[self.selectedPhotoIndex])
                        self.detailPhoto?.transform = CGAffineTransform.identity
                    }, completion: nil)
                })
            }) { (finished: Bool) in
                self.infoLable?.text = "Selected index: \(self.selectedPhotoIndex), count \(self.allPhotoesNames.count)"
            }
            
//            selectedPhotoIndex += 1
//            self.detailPhoto?.image = UIImage(named: allPhotoesNames[selectedPhotoIndex])
//
            print("left swipe")
        case .up:
            self.dismiss(animated: true, completion: nil)
            
            print("up swipe")
        default:
            break
        }
        
    }
    
    private func swipeObserves (){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
        swipeRight.direction = .right
        self.detailPhoto?.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
        swipeLeft.direction = .left
        self.detailPhoto?.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestoreRecogniser))
        swipeUp.direction = .up
        self.detailPhoto?.addGestureRecognizer(swipeUp)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
