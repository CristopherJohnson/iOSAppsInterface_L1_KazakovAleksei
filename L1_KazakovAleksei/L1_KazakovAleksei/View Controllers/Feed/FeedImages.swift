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
    
    var id: Int?
    
    weak var cell: FeedTableViewCell?
    
    
    
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviewes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviewes()
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
    
    public func setPostImage (imageName name: String) {
        let imageName = name
        let image = UIImage(named: imageName)
        self.postImageView?.image = image
        
        self.postImageView?.contentMode = UIView.ContentMode.scaleAspectFill
        self.postImageView?.clipsToBounds = true
    }
    
    public func reuse() {
        self.postImageView?.image = nil
    }
    
    public func setId (id: Int) {
        self.id = id
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("layoutSubviews")
        
        self.postImageView?.frame = self.bounds
        self.button?.frame = self.bounds
        
        var inset: CGFloat = 0
        if let isTouched = self.button?.isHighlighted, isTouched == true {
            inset = self.insert
        }
        self.postImageView?.frame = CGRect(x: inset,
                                           y: inset,
                                           width: self.frame.size.width - (inset * 2),
                                           height: self.frame.size.height - (inset * 2))
    }
    
    //MARK: - Actions
    
    @objc func touchDown () {
        print("touchDown")
        self.animateDefault()
    }
    
    @objc func touchUpInside () {
        print("touchUpInside")
        self.button?.isHighlighted = false
        self.animateWithJump()
        self.cell?.didSelectedImage(image: self)
        
    }
    
    @objc func touchUpOutside () {
        print("touchUpOutside")
        self.animateDefault()
    }
    
    @objc func touchCanceled () {
        print("touchCanceled")
        self.animateDefault()
    }
    
    // MARK: - Animations
    
    private func animateDefault() {
        UIView.animate(withDuration: 0.1) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private func animateWithJump() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }) { (finished: Bool) in
            
        }

    }
    
    
}
