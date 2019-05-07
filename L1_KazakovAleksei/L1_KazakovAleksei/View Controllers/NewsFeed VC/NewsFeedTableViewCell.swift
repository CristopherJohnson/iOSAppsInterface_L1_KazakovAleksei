//
//  NewsFeedTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    private weak var postAuthorView: PostAuthorView?
    private weak var postBottomView: PostBottomView?
    private weak var containerView: UIView?
    private weak var newsTextLabel: UILabel?
    private weak var limitView: UIView?
    weak var showFull: UIButton?
    
    let compactTextHeight: CGFloat = 144
//    let limitHeight: CGFloat = 28
    
    public func addSubviews () {
        if self.containerView == nil {
            let view = UIView()
            view.frame = CGRect.zero
            addSubview(view)
            containerView = view
        }
        if self.postAuthorView == nil {
            let postView = PostAuthorView()
            postView.frame = CGRect.zero
            self.containerView?.addSubview(postView)
            self.postAuthorView = postView
        }
        if self.postBottomView == nil{
            let bottomView = PostBottomView()
            bottomView.frame = CGRect.zero
            self.containerView?.addSubview(bottomView)
            self.postBottomView = bottomView
        }
        if self.newsTextLabel == nil {
            let label = UILabel()
            label.frame = CGRect.zero
            self.containerView?.addSubview(label)
            self.newsTextLabel = label
        }
        
        if self.showFull == nil {
            let button = UIButton()
            button.frame = CGRect.zero
            self.containerView?.addSubview(button)
            self.showFull = button
        }
    }
    
    public func setup (post: NewsFeedModel) {
        
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        self.containerView?.frame = CGRect(x: 6, y: 6, width: (self.frame.size.width - 12), height: (self.frame.size.height - 12))
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.layer.cornerRadius = 10
        self.containerView?.clipsToBounds = true

        let postAuthorImageUrl = post.groupAuthor?.imageURL ?? post.userAuthor?.imageURL
        self.postAuthorView?.setup(imageUrl: postAuthorImageUrl!, authorName: post.getAuthorName(), date: post.date)
        self.postAuthorView?.frame = CGRect(x: 6, y: 6, width: (self.containerView?.bounds.size.width)! - 12, height: post.autorViewHeigh)
        
        
        if let text = post.postText {
            let postPositionY = (self.postAuthorView?.frame.size.height)! + 12
            if text.count > 0 && post.compactHeight == nil  {
                self.newsTextLabel?.text = text
                self.newsTextLabel?.numberOfLines = 0
                self.newsTextLabel?.frame = CGRect(x: 6, y: postPositionY, width: (self.containerView?.bounds.size.width)! - 12, height: post.textHeigh!)
            } else if text.count > 0 && post.compactHeight != nil {
                self.newsTextLabel?.text = text
                self.newsTextLabel?.numberOfLines = 0
                self.newsTextLabel?.frame = CGRect(x: 6, y: postPositionY, width: (self.containerView?.bounds.size.width)! - 12, height: (post.isCompact ? post.compactTextlimit : post.textHeigh)!)
                self.showFull?.frame = CGRect(x: 6, y: (postPositionY + (self.newsTextLabel?.frame.size.height)!), width: (self.containerView?.bounds.size.width)! - 12, height: post.bottomViewHeigh)
                self.showFull?.setTitle(post.isCompact ? "Показать полностью" : "Показать меньше", for: .normal)
                self.showFull?.setTitleColor(UIColor(red: 85/255, green: 140/255, blue: 202/255, alpha: 1), for: .normal)
                self.showFull?.backgroundColor = UIColor.clear
                
                self.showFull?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.showFull?.titleLabel?.textAlignment = .left
                self.showFull?.sizeToFit()
                
                
            }
        }
        

        let postBottomViewPositionY = (self.containerView?.frame.height)! - post.bottomViewHeigh
        self.postBottomView?.frame = CGRect(x: 0, y: postBottomViewPositionY, width: (self.containerView?.bounds.size.width)!, height: post.bottomViewHeigh)
        self.postBottomView?.setup(likesCount: post.likesCount ?? 0, repostsCount: post.repostsCount ?? 0, commentsCount: post.commentsCount ?? 0, viewsCount: post.viewsCount ?? 0)
        
        
    }
    
    func updateContent (post: NewsFeedModel) {
        print("click show full post text: \(String(describing: post.postText)), post is compact \(post.isCompact)")
        let realTextHieght = post.isCompact ? post.compactTextlimit : post.textHeigh
        let postHeight = post.isCompact ? post.compactHeight : post.totalHeight
//
        if var frame = containerView?.frame {
            frame.size.height = postHeight! - 12
            containerView?.frame = frame
        }
//
        if var frame = newsTextLabel?.frame {
            frame.size.height = realTextHieght!
            newsTextLabel?.frame = frame
            newsTextLabel?.text = post.postText
        }
        
        if var frame = showFull?.frame {
            frame.origin.y = (self.postAuthorView?.frame.size.height)! + 12 + realTextHieght!
            self.showFull?.frame = frame
            self.showFull?.setTitle(post.isCompact ? "Показать полностью" : "Показать меньше", for: .normal)
            self.showFull?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.showFull?.sizeToFit()
            
        }
//
        if var frame = postBottomView?.frame, let containerHeight = containerView?.bounds.size.height {
            frame.origin.y = containerHeight - post.bottomViewHeigh
            postBottomView?.frame = frame
        }
        
//        newsTextLabel?.text = text
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.addSubviews()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsTextLabel?.text = nil
        self.postAuthorView?.reuse()
        self.postBottomView?.reuse()
        self.showFull?.titleLabel?.text = nil
        self.containerView?.frame = CGRect.zero
//        self.containerView?.frame = CGRect.zero
        self.postAuthorView = nil

        self.containerView = nil
        self.newsTextLabel = nil
        self.postBottomView = nil
        self.showFull = nil
    }

}
