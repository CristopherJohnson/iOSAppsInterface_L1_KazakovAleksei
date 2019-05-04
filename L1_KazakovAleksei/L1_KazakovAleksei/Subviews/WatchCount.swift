//
//  WatchCount.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 26/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class WatchCount: UIView {
    var counter: Int = 0 {
        didSet {
            if counter > 1000 {
                self.countLable?.text = "\(Int(self.counter / 1000))k"
            } else {
                self.countLable?.text = "\(self.counter)"
            }
            
            self.layoutSubviews()
        }
    }

    private weak var iconImageView: UIImageView?
    private weak var countLable: UILabel?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAppearance()
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAppearance()
        self.addSubviews()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.iconImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height)
        self.iconImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.countLable?.frame = CGRect(x: self.frame.size.width / 2, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height)
        self.countLable?.font = UIFont.systemFont(ofSize: 14)
        self.countLable?.textAlignment = .left
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
        self.iconImageView?.image = UIImage(named: "views_icon")
    }
    
    private func addCountLable() {
        if self.countLable != nil {
            return
        }
        
        let countLable = UILabel()
        self.addSubview(countLable)
        self.countLable = countLable
        let textColor = UIColor(red: (115 / 255), green: (162 / 255), blue: (172 / 255), alpha: 1)
        self.countLable?.textColor = textColor
        
        self.countLable?.text = "\(self.counter)"
        
    }

    public func reuse () {
        self.countLable?.text = nil
        self.iconImageView?.image = nil
    }
}
