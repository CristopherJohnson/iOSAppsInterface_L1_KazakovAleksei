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
    
    public func setup (post: NewsFeedModel) {
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        
        if self.containerView == nil {
            let view = UIView(frame: CGRect(x: 6, y: 6, width: bounds.size.width - 12, height: bounds.size.height - 12))
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            addSubview(view)
            containerView = view
        }
        
        if self.postAuthorView == nil {
            let postView = PostAuthorView()
            let postAuthorImageUrl = post.groupAuthor?.imageURL ?? post.userAuthor?.imageURL
            postView.setup(imageUrl: postAuthorImageUrl!, authorName: post.getAuthorName(), date: post.date)
            postView.frame = CGRect(x: 0, y: 0, width: (self.containerView?.bounds.size.width)!, height: 45)
            self.containerView?.addSubview(postView)
            self.postAuthorView = postView
        }
        
        if self.postBottomView == nil {
            let positionY = (self.postAuthorView?.frame.size.height)! + 6
            let bottomView = PostBottomView()
            bottomView.frame = CGRect(x: 0, y: positionY, width: (self.containerView?.bounds.size.width)!, height: 25)
            bottomView.setup(likesCount: post.likesCount ?? 0, repostsCount: post.repostsCount ?? 0, commentsCount: post.commentsCount ?? 0, viewsCount: post.viewsCount ?? 0)
            
            
            self.containerView?.addSubview(bottomView)
            self.postBottomView = bottomView
        }
        
    }

}
