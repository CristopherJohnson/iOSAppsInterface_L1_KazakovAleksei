//
//  LikeButton.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class LikeButton: UIControl {
    
    var counter: Int = 10
    
    var isLiked: Bool = false {
        didSet {
            self.update()
            self.sendActions(for: .valueChanged)
        }
        
        willSet {
            if newValue == true {
                self.counter += 1
                UIView.transition(with: countLable!, duration: 0.2, options: .transitionFlipFromTop, animations: {
                    self.countLable?.text = "\(self.counter)"
                }) { (finished: Bool) in
                   
                }
            } else {
                self.counter -= 1
                UIView.transition(with: countLable!, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                    self.countLable?.text = "\(self.counter)"
                }) { (finished: Bool) in
                    
                }
            }
        }
    }
    
    private weak var iconImageView: UIImageView?
    private weak var countLable: UILabel?
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAppearance()
        self.addSubviews()
        self.addGestures()
        self.update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAppearance()
        self.addSubviews()
        self.addGestures()
        self.update()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.iconImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height)
        self.iconImageView?.contentMode = UIView.ContentMode.scaleAspectFill
        self.countLable?.frame = CGRect(x: self.frame.size.width / 2, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height)
    }
    
    // MARK: - Actions
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapAction(tap: UITapGestureRecognizer){
        self.isLiked = !self.isLiked

    }
    
    // MARK: - Appearance
    
    private func setAppearance() {
        self.backgroundColor = UIColor.white
    }
    
    private func addSubviews() {
        self.addIconImageView()
        self.addCountLable()
    }
    
    private func addIconImageView() {
        if self.iconImageView != nil {
            return
        }
        
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        self.iconImageView = iconImageView
    }
    
    private func addCountLable() {
        if self.countLable != nil {
            return
        }
        
        let countLable = UILabel()
        self.addSubview(countLable)
        self.countLable = countLable
    }

    // MARK: - Update
    
    private func update() {
        self.updateIconImageView()
        self.updateCountLable()
    }
    
    private func updateIconImageView() {
        let imageName = self.isLiked ? "like" : "unlike"
        let image = UIImage(named: imageName)
        self.iconImageView?.image = image
    }
    
    private func updateCountLable() {
        let textColor = self.isLiked ? UIColor.red : UIColor.gray
        self.countLable?.textColor = textColor
        
        self.countLable?.text = "\(self.counter)"
    }
 

}
