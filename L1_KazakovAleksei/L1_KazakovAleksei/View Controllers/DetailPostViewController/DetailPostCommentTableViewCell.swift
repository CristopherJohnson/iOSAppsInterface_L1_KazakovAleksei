//
//  DetailPostCommentTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 31/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class DetailPostCommentTableViewCell: UITableViewCell {

    private weak var containerView: UIView?
    private weak var commentView: CommentView?
    
    public func addSubviews() {
        if self.containerView == nil {
            let view = UIView()
            view.frame = CGRect.zero
            addSubview(view)
            containerView = view
        }
        
        if self.commentView == nil {
            let view = CommentView()
            view.frame = CGRect.zero
            self.containerView?.addSubview(view)
            commentView = view
        }
    }
    
    public func setup (comment: CommentsModel) {
        
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        self.containerView?.frame = CGRect(x: 0, y: 6, width: (self.frame.size.width - 12), height: self.frame.size.height)
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.clipsToBounds = true
        
        let commentAuthorImageUrl = comment.groupAuthor?.imageURL ?? comment.userAuthor?.imageURL
        
        self.commentView?.setup(imageURL: commentAuthorImageUrl!, authorName: comment.getAuthorName(), commentText: comment.commentText, textHeight: comment.textHeight)
        self.commentView?.frame = CGRect(x: 6, y: 6, width: (self.containerView?.bounds.size.width)! - 12, height: (comment.textHeight ?? 10 + 20))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.containerView?.frame = CGRect.zero
        self.commentView?.reuse()
        
        self.containerView = nil
        self.commentView = nil
    }

}
