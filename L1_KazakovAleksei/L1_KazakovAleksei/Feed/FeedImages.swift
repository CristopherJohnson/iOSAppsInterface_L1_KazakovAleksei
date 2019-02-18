//
//  FeedImagesStack.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 18/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class FeedImages: UIView {
    
    private weak var postImageView: UIImageView?
    private weak var button: UIButton?
    
    private let insert: CGFloat = 5.0
    
    private var isTouched: Bool = false
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviewes()
        self.addPostImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviewes()
        self.addPostImage()
    }
    
    // MARK: - Layout
    
    private func addSubviewes() {
        self.addPostImageView()
        self.addButton()        
    }
    
    private func addPostImageView() {
        if self.postImageView != nil {
            return
        }
        let imageView = UIImageView()
        self.addSubview(imageView)
        self.postImageView = imageView
    }
    
    private func addButton() {
        if self.button != nil {
            return
        }
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        button.addTarget(self, action: #selector(touchCanceled), for: .touchCancel)
        self.addSubview(button)
        self.button = button
        
    }
    
    func addPostImage () {
        let imageName = "test"
        let image = UIImage(named: imageName)
        self.postImageView?.image = image
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.postImageView?.frame = self.bounds
        if self.isTouched == true {
            self.postImageView?.frame = CGRect(x: 0 + self.insert, y: 0 + self.insert, width: self.frame.size.width - (self.insert * 2), height: self.frame.size.height - (self.insert * 2))
        } else {
            self.postImageView?.frame = self.bounds
        }
        
        self.postImageView?.contentMode = UIView.ContentMode.scaleAspectFill
        self.postImageView?.clipsToBounds = true
        self.button?.frame = self.bounds
        print("layoutSubviews")
    }
    
    @objc func touchDown () {
        print("touchDown")
        UIView.animate(withDuration: 0.2) {
            self.isTouched = true
            self.layoutIfNeeded()
            self.postImageView?.frame = CGRect(x: 0 + self.insert, y: 0 + self.insert, width: self.frame.size.width - (self.insert * 2), height: self.frame.size.height - (self.insert * 2))
        }
    }
    
    @objc func touchUpInside () {
        print("touchUpInside")
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
            self.isTouched = false
            self.layoutIfNeeded()
            self.postImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }) { (finished: Bool) in
            
        }
    }
    
    @objc func touchUpOutside () {
        print("touchUpOutside")
        UIView.animate(withDuration: 0.2) {
            self.isTouched = false
            self.layoutIfNeeded()
            self.postImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    @objc func touchCanceled () {
        print("touchCanceled")
        UIView.animate(withDuration: 0.2) {
            self.isTouched = false
            self.layoutIfNeeded()
            self.postImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    
}
