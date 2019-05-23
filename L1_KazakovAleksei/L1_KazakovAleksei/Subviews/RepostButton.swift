//
//  RepostButton.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 26/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class RepostButton: UIControl {

    var counter: Int = 0 {
        didSet {
            if counter > 1000000 {
                let count: Double = Double(counter / 1000000)
                self.countLable?.text = "\(Double(round(10 * count)/10))M"
            } else if counter > 10000 {
                self.countLable?.text = "\(Int(self.counter / 10000))K"
            } else {
                self.countLable?.text = "\(self.counter)"
            }
            
            self.layoutSubviews()
        }
    }
    
    var isReposted: Bool = false {
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
        
        self.iconImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        self.iconImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.countLable?.frame = CGRect(x: (self.frame.size.height + 5), y: 0, width: (self.frame.size.width - self.frame.size.height - 5), height: self.frame.size.height)
        self.countLable?.font = UIFont.systemFont(ofSize: 14)
        self.countLable?.textAlignment = .left
    }
    
    // MARK: - Actions
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapAction(tap: UITapGestureRecognizer){
        //        self.isLiked = !self.isLiked
        
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
        let imageName = "share"
        let image = UIImage(named: imageName)
        self.iconImageView?.image = image
    }
    
    private func updateCountLable() {
        let textColor = self.isReposted ? UIColor.red : UIColor(red: (115 / 255), green: (162 / 255), blue: (172 / 255), alpha: 1)
        self.countLable?.textColor = textColor
        
        self.countLable?.text = "\(self.counter)"
    }

    public func reuse () {
        self.countLable?.text = nil
        self.iconImageView?.image = nil
    }

}
