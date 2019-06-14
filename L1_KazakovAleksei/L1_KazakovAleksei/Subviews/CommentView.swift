//
//  CommentView.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 31/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class CommentView: UIView {

    private weak var authorImageView: UIImageView?
    private weak var authorNameLabel: UILabel?
    private weak var commentTextLabel: UILabel?
    
    private var textHeight: CGFloat = 0
    private var isReply: Bool = false
    private weak var bottomView: CommentBottomView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviews()
    }
    
    private func addSubviews () {
        if self.authorImageView == nil {
            let imageView = UIImageView()
            self.addSubview(imageView)
            self.authorImageView = imageView
        }
        
        if self.authorNameLabel == nil {
            let label = UILabel()
            self.addSubview(label)
            self.authorNameLabel = label
        }
        
        if self.commentTextLabel == nil {
            let label = UILabel()
            self.addSubview(label)
            self.commentTextLabel = label
        }
        
        if self.bottomView == nil {
            let view = CommentBottomView()
            self.addSubview(view)
            self.bottomView = view
        }
    }
    
    public func reuse () {
        self.authorImageView?.image = nil
        self.authorNameLabel?.text = nil
        self.commentTextLabel?.text = nil
        self.commentTextLabel?.frame = CGRect.zero
        self.textHeight = 0
        self.bottomView?.reuse()
    }
    
    public func setup (imageURL: String, authorName: String, commentText: String?, textHeight: CGFloat?, isReply: Bool, date: Date?, likesCount: Int) {
        ImageService.shared.get(urlString: imageURL) { (image: UIImage?) in
            if let loadedImage = image {
                self.authorImageView?.image = loadedImage
            } else {
                print("post author Image loading error")
            }
        }
        
        self.authorNameLabel?.text = authorName
        
        if let text = commentText {
            self.commentTextLabel?.text = text
            self.commentTextLabel?.isHidden = false
        } else {
            self.commentTextLabel?.isHidden = true
        }
        if let height = textHeight {
            self.textHeight = height
        }
        self.isReply = isReply
        self.bottomView?.setup(date: date, likesCount: likesCount)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.authorImageView?.frame = CGRect(x: 0, y: 0, width: self.isReply ? 27 : 30, height: self.isReply ? 27 : 30)
        self.authorImageView?.layer.cornerRadius = (self.authorImageView?.frame.size.width)! / 2
        self.authorImageView?.layer.masksToBounds = true
        
        let labelX: CGFloat = (self.authorImageView?.frame.size.width)! + 6
        let labelWidth: CGFloat = self.frame.size.width - labelX - 6
        
        self.authorNameLabel?.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: 20)
        self.authorNameLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        self.authorNameLabel?.textColor = UIColor(red: 0.23, green: 0.36, blue: 0.53, alpha: 1)
        
        var positionY: CGFloat = 20
        
        if !(self.commentTextLabel?.isHidden)! {
            self.commentTextLabel?.frame = CGRect(x: labelX, y: 20, width: labelWidth, height: textHeight)
            self.commentTextLabel?.font = UIFont.systemFont(ofSize: 15)
            self.commentTextLabel?.numberOfLines = 0
            positionY += (self.commentTextLabel?.frame.size.height)!
        } else {
            positionY += self.isReply ? 7 : 10
        }
        positionY += 6
        
        self.bottomView?.frame = CGRect(x: labelX, y: positionY, width: labelWidth, height: 20)
    }
    
}