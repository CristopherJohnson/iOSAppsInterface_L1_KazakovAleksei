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
    private var replyesComments: [CommentView] = []
    
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
        self.containerView?.frame = CGRect(x: 0, y: 6, width: self.frame.size.width, height: (self.frame.size.height - 12))
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.clipsToBounds = true
        
        var positionY: CGFloat = 6
        
        let commentAuthorImageUrl = comment.currentComment.groupAuthor?.imageURL ?? comment.currentComment.userAuthor?.imageURL
        
        self.commentView?.setup(imageURL: commentAuthorImageUrl!, authorName: comment.currentComment.getAuthorName(), commentText: comment.currentComment.commentText, textHeight: comment.currentComment.commentTextHeight, isReply: false, date: comment.currentComment.date, likesCount: comment.currentComment.likesCount ?? 0)
        self.commentView?.frame = CGRect(x: 6, y: positionY, width: (self.containerView?.bounds.size.width)! - 12, height: (comment.currentComment.commentViewHeihgt))
        positionY += comment.currentComment.commentViewHeihgt
        positionY += 6
        
        if comment.threadComments.count > 0 {
            
            for threadComment in comment.threadComments {
                let replyComment = CommentView()
                positionY += 6
                let commentAuthorImageUrl = threadComment.groupAuthor?.imageURL ?? threadComment.userAuthor?.imageURL
                replyComment.setup(imageURL: commentAuthorImageUrl!, authorName: threadComment.getAuthorName(), commentText: threadComment.commentText, textHeight: threadComment.commentTextHeight, isReply: true, date: threadComment.date, likesCount: threadComment.likesCount ?? 0)
                replyComment.frame = CGRect(x: 42, y: positionY, width: (self.containerView?.bounds.size.width)! - 48, height: (threadComment.commentViewHeihgt))
                positionY += threadComment.commentViewHeihgt
                positionY += 6
                self.addSubview(replyComment)
                self.replyesComments.append(replyComment)
            }
            
        }
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.containerView?.frame = CGRect.zero
        self.commentView?.reuse()
        
        self.containerView = nil
        self.commentView = nil
        
        for comment in self.replyesComments {
            comment.reuse()
            comment.removeFromSuperview()
        }
        
        self.replyesComments.removeAll()
    }

}
