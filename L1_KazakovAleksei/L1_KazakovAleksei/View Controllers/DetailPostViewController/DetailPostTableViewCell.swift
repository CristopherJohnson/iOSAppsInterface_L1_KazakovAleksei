//
//  DetailPostTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 30/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class DetailPostTableViewCell: UITableViewCell {

    private weak var postAuthorView: PostAuthorView?
    private weak var postBottomView: PostBottomView?
    private weak var containerView: UIView?
    private weak var newsTextLabel: UILabel?
    private weak var photoView: PhotoView?
    private var linksArray: [LinkModel] = []
    public weak var delegate: OpenDetailPostLink?
    
    public var indexPath: IndexPath?
    
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
            label.translatesAutoresizingMaskIntoConstraints = false
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            self.containerView?.addSubview(label)
            self.newsTextLabel = label
        }
        
        
        if self.photoView == nil {
            let view = PhotoView()
            view.frame = CGRect.zero
            self.containerView?.addSubview(view)
            self.photoView = view
        }
    }
    
    public func setup (post: NewsFeedModel, complition: @escaping ()->()) {
        var totalSpace: CGFloat = 6
        var viewsHeight: CGFloat = 0
        
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        self.containerView?.frame = CGRect(x: 6, y: 6, width: (self.frame.size.width - 12), height: (self.frame.size.height - 12))
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.layer.cornerRadius = 10
        self.containerView?.clipsToBounds = true
        
        let postAuthorImageUrl = post.groupAuthor?.imageURL ?? post.userAuthor?.imageURL
        self.postAuthorView?.frame = CGRect(x: totalSpace, y: totalSpace, width: (self.containerView?.bounds.size.width)! - 12, height: post.autorViewHeigh)
        self.postAuthorView?.setup(imageUrl: postAuthorImageUrl!, authorName: post.getAuthorName(), date: post.date)
        
        totalSpace += 6
        viewsHeight += (postAuthorView?.frame.size.height)!
        
        
        if let text = post.postText {
            self.newsTextLabel?.frame = CGRect(x: 6, y: totalSpace + viewsHeight, width: (self.containerView?.bounds.size.width)! - 12, height: (post.textHeigh)!)
            viewsHeight += (newsTextLabel?.frame.size.height)!
            totalSpace += 6
            self.newsTextLabel?.attributedText = NSMutableAttributedString(string: text)
            self.newsTextLabel?.numberOfLines = 0
            
            if post.linksArray.count > 0 {
                let attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: text.count))
                for link in post.linksArray {
                    attributedString.addAttribute(.foregroundColor, value: UIColor(red: 85/255, green: 140/255, blue: 202/255, alpha: 1), range: link.range)
                }
                self.newsTextLabel?.attributedText = attributedString
                self.linksArray = post.linksArray
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openLabelLink(_:)))
                self.newsTextLabel?.addGestureRecognizer(gestureRecognizer)
                newsTextLabel?.isUserInteractionEnabled = true
            } else {
                newsTextLabel?.isUserInteractionEnabled = false
                newsTextLabel?.textColor = UIColor.black
            }
        }
        
        if post.photos.count > 0 {
            self.photoView?.frame = CGRect(x: 0, y: totalSpace + viewsHeight, width: (self.containerView?.frame.size.width)!, height: post.totalPhotosHeigh!)
            self.photoView?.setup(photos: post.photos)
        }
        
        
        let postBottomViewPositionY = (self.containerView?.frame.height)! - post.bottomViewHeigh
        self.postBottomView?.frame = CGRect(x: 0, y: postBottomViewPositionY, width: (self.containerView?.bounds.size.width)!, height: post.bottomViewHeigh)
        self.postBottomView?.setup(likesCount: post.likesCount ?? 0, repostsCount: post.repostsCount ?? 0, commentsCount: post.commentsCount ?? 0, viewsCount: post.viewsCount ?? 0)
        
      complition()
    }
    
    @objc func openLabelLink (_ recognizer: UITapGestureRecognizer) {
        if let label = self.newsTextLabel {
            for link in self.linksArray {
                if recognizer.didTapAttributedTextInLabel(label: label, inRange: link.range) {
                    self.delegate?.openLink(link: link.link)
                    return
                }
            }
        }
        
    }
    
//    private func reloadCell () {
//        if let indexPath = self.indexPath {
//            self.delegate?.reloadCell(atIndexPath: indexPath)
//        }
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.newsTextLabel?.numberOfLines = 0
//        self.newsTextLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
//        self.newsTextLabel?.adjustsFontSizeToFitWidth = false
//        self.newsTextLabel?.sizeToFit()
        
//        print(self.newsTextLabel?.attributedText as Any)
    }
    
    public func refresh () {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.newsTextLabel?.text = nil
        self.newsTextLabel?.gestureRecognizers?.removeAll()
        self.newsTextLabel?.attributedText = nil
        self.newsTextLabel = nil
        self.postAuthorView?.reuse()
        self.postBottomView?.reuse()
        self.containerView?.frame = CGRect.zero
        self.photoView?.reuse()
        self.linksArray.removeAll()
        self.delegate = nil
        self.photoView = nil
        self.postAuthorView = nil
        self.indexPath = nil
        self.containerView = nil
//        self.newsTextLabel = nil
        self.postBottomView = nil
    }

}
