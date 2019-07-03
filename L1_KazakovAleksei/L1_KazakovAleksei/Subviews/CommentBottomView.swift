//
//  CommentBottomView.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 14/06/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class CommentBottomView: UIView {

    private weak var dateLabel: UILabel?
    private weak var replyButton: UIButton?
    private weak var likeView: LikeButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviews()
    }
    
    private func addSubviews () {
        if self.dateLabel == nil {
            let label = UILabel()
            self.addSubview(label)
            self.dateLabel = label
        }
        
        if self.replyButton == nil {
            let button = UIButton()
            self.addSubview(button)
            self.replyButton = button
        }
        
        if self.likeView == nil {
            let view = LikeButton()
            self.addSubview(view)
            self.likeView = view
        }
    }
    
    public func setup (date: Date?, likesCount: Int) {
        if let commentDate = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM в HH:mm"
            formatter.locale = Locale(identifier: "ru")
            self.dateLabel?.text = formatter.string(from: commentDate)
        } else {
            self.dateLabel?.text = "Date error"
        }
        
        self.likeView?.counter = likesCount
        
    }
    
    public func reuse () {
        self.likeView?.reuse()
        self.dateLabel?.text = nil
        self.replyButton?.titleLabel?.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dateLabel?.font = UIFont.systemFont(ofSize: 15)
        let dateLabelWidth = dateLabel?.text?.widthOfString(withConstrainedHeight: self.frame.size.height, font: UIFont.systemFont(ofSize: 15)) ?? 100
        var posX: CGFloat = dateLabelWidth
        self.dateLabel?.frame = CGRect(x: 0, y: 0, width: dateLabelWidth, height: self.frame.size.height)
        posX += 5
        self.replyButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.replyButton?.titleLabel?.textColor = UIColor(red: 0.23, green: 0.36, blue: 0.53, alpha: 1)
        self.replyButton?.setTitle("Ответить", for: .normal)
        let repluButtonWidth = self.replyButton?.titleLabel?.text?.widthOfString(withConstrainedHeight: self.frame.size.height, font: UIFont.systemFont(ofSize: 15, weight: .medium)) ?? 80
        self.replyButton?.frame = CGRect(x: posX, y: 0, width: repluButtonWidth, height: self.frame.size.height)
        posX += repluButtonWidth + 5
        self.replyButton?.setTitleColor(UIColor(red: 0.23, green: 0.36, blue: 0.53, alpha: 1), for: .normal)
//        self.replyButton?.sizeToFit()
        self.replyButton?.titleLabel?.textAlignment = .left
        
        self.likeView?.frame = CGRect(x: posX, y: 0, width: self.frame.size.width - posX, height: self.frame.size.height)
        
    }
}
