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
    }
    
    public func reuse () {
        self.authorImageView?.image = nil
        self.authorNameLabel?.text = nil
        self.commentTextLabel?.text = nil
        self.commentTextLabel?.frame = CGRect.zero
        self.textHeight = 0
    }
    
    public func setup (imageURL: String, authorName: String, commentText: String?, textHeight: CGFloat?) {
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.authorImageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.authorImageView?.layer.cornerRadius = 15
        self.authorImageView?.layer.masksToBounds = true
        
        let labelX: CGFloat = (self.authorImageView?.frame.size.width)! + 3
        let labelWidth: CGFloat = self.frame.size.width - labelX
        
        self.authorNameLabel?.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: 20)
        self.authorNameLabel?.font = UIFont.systemFont(ofSize: 15)
        
        if !(self.commentTextLabel?.isHidden)! {
            self.commentTextLabel?.frame = CGRect(x: labelX, y: 20, width: labelWidth, height: textHeight)
            self.commentTextLabel?.font = UIFont.systemFont(ofSize: 15)
            self.commentTextLabel?.numberOfLines = 0
        }
    }
    
}
