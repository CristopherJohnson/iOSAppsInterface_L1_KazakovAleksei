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
    
    private func addSubviews () {
        if self.containerView == nil {
            let view = UIView()
            addSubview(view)
            containerView = view
        }
        if self.postAuthorView == nil {
            let postView = PostAuthorView()
            self.containerView?.addSubview(postView)
            self.postAuthorView = postView
        }
        if self.postBottomView == nil{
            let bottomView = PostBottomView()
            self.containerView?.addSubview(bottomView)
            self.postBottomView = bottomView
        }
        if self.newsTextLabel == nil {
            let label = UILabel()
            self.containerView?.addSubview(label)
            self.newsTextLabel = label
        }
    }
    
    public func setup (post: NewsFeedModel) {
        self.addSubviews()
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        self.containerView?.frame = CGRect(x: 6, y: 6, width: bounds.size.width - 12, height: bounds.size.height - 12)
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.layer.cornerRadius = 10
        self.containerView?.clipsToBounds = true

        let postAuthorImageUrl = post.groupAuthor?.imageURL ?? post.userAuthor?.imageURL
        self.postAuthorView?.setup(imageUrl: postAuthorImageUrl!, authorName: post.getAuthorName(), date: post.date)
        self.postAuthorView?.frame = CGRect(x: 6, y: 6, width: (self.containerView?.bounds.size.width)! - 12, height: post.autorViewHeigh)
        
        
        if let text = post.postText {
            let postPositionY = (self.postAuthorView?.frame.size.height)! + 12
            if text.count > 0 && post.isCompact == false  {
                self.newsTextLabel?.text = text
                self.newsTextLabel?.numberOfLines = 0
                self.newsTextLabel?.frame = CGRect(x: 6, y: postPositionY, width: (self.containerView?.bounds.size.width)! - 12, height: post.textHeigh!)
            }
        }
        

        let postBottomViewPositionY = (self.containerView?.frame.height)! - post.bottomViewHeigh
        self.postBottomView?.frame = CGRect(x: 0, y: postBottomViewPositionY, width: (self.containerView?.bounds.size.width)!, height: post.bottomViewHeigh)
        self.postBottomView?.setup(likesCount: post.likesCount ?? 0, repostsCount: post.repostsCount ?? 0, commentsCount: post.commentsCount ?? 0, viewsCount: post.viewsCount ?? 0)
        
        
    }
    
    func updateContent (text: String?, textHeight: CGFloat, totalHeight: CGFloat, isCompact: Bool) {
        
//        limitView?.alpha = isCompact ? 1 : 0
        
        let realTextHieght = isCompact ? compactTextHeight : textHeight
        
        if var frame = containerView?.frame {
            frame.size.height = totalHeight - 12
            containerView?.frame = frame
        }
        
        if var frame = newsTextLabel?.frame {
            frame.size.height = realTextHieght
            newsTextLabel?.frame = frame
        }
        
//        if var frame = limitView?.frame, let containerHeight = containerView?.bounds.size.height {
//            frame.origin.y = containerHeight - 25 - limitHeight
//            limitView?.frame = frame
//        }
        if var frame = postBottomView?.frame, let containerHeight = containerView?.bounds.size.height {
            frame.origin.y = containerHeight - 25
            postBottomView?.frame = frame
        }
        newsTextLabel?.text = text
    }

}
