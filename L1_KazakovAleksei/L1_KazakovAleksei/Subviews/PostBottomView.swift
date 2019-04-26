//
//  PostBottomView.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class PostBottomView: UIView {

    private weak var likeView: LikeButton?
    private weak var commentView: CommetButton?
    private weak var repostView: RepostButton?
    private weak var watchView: WatchCount?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviews()
    }
    
    
    //MARK: - Setup
    
    private func addSubviews() {
        self.backgroundColor = UIColor.clear
        if self.likeView == nil {
            let view = LikeButton()
            self.addSubview(view)
            self.likeView = view
        }
        if self.commentView == nil {
            let view = CommetButton()
            self.addSubview(view)
            self.bringSubviewToFront(view)
            self.commentView = view
        }
        if self.repostView == nil {
            let view = RepostButton()
            self.addSubview(view)
            self.repostView = view
        }
        if self.watchView == nil {
            let view = WatchCount()
            self.addSubview(view)
            self.watchView = view
        }
    }
    
    public func setup (likesCount: Int, repostsCount: Int, commentsCount: Int, viewsCount: Int) {
        self.likeView?.counter = likesCount
        self.commentView?.counter = commentsCount
        self.repostView?.counter = repostsCount
        self.watchView?.counter = viewsCount
    }
    
    //MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let space: CGFloat = (self.frame.size.width * 0.04)
        let width: CGFloat = (self.frame.size.width * 0.2)
        
        self.likeView?.frame = CGRect(x: space, y: 0, width: width, height: self.frame.size.height)
        self.repostView?.frame = CGRect(x: (space * 2 + width), y: 0, width: width, height: self.frame.size.height)
        self.commentView?.frame = CGRect(x: (space * 3 + width * 2), y: 0, width: width, height: self.frame.size.height)
        self.watchView?.frame = CGRect(x: (space * 4 + width * 3), y: 0, width: width + space, height: self.frame.size.height)

    }
}
