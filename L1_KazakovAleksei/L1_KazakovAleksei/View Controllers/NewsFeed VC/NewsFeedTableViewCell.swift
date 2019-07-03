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
    weak var newsTextLabel: UILabel?
//    private weak var limitView: UIView?
    weak var showFull: UIButton?
    private weak var photoView: PhotoView?
    
    public var indexPath: IndexPath?
    
    let compactTextHeight: CGFloat = 144
    private var linksArray: [LinkModel] = []
//    let limitHeight: CGFloat = 28
    
    public weak var delegate: OpenLink?
    
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
        
        if self.photoView == nil {
            let view = PhotoView()
            view.frame = CGRect.zero
            self.containerView?.addSubview(view)
            self.photoView = view
        }
    }
    
    public func setup (post: NewsFeedModel) {
        
        var totalSpace: CGFloat = 6
        var viewsHeight: CGFloat = 0
        
        self.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        self.containerView?.frame = CGRect(x: 6, y: 6, width: (self.frame.size.width - 12), height: (self.frame.size.height - 12))
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.layer.cornerRadius = 10
        self.containerView?.clipsToBounds = true

        let postAuthorImageUrl = post.groupAuthor?.imageURL ?? post.userAuthor?.imageURL
        self.postAuthorView?.setup(imageUrl: postAuthorImageUrl!, authorName: post.getAuthorName(), date: post.date)
        self.postAuthorView?.frame = CGRect(x: totalSpace, y: totalSpace, width: (self.containerView?.bounds.size.width)! - 12, height: post.autorViewHeigh)
        totalSpace += 6
        viewsHeight += (postAuthorView?.frame.size.height)!
        
        
        if let text = post.postText {
            if text.count > 0 && post.compactHeight == nil  {
                self.newsTextLabel?.attributedText = NSMutableAttributedString(string: text)

                self.newsTextLabel?.numberOfLines = 0
                self.newsTextLabel?.frame = CGRect(x: 6, y: totalSpace + viewsHeight, width: (self.containerView?.bounds.size.width)! - 12, height: post.textHeigh!)
                totalSpace += 6
                viewsHeight += (newsTextLabel?.frame.size.height)!
            } else if text.count > 0 && post.compactHeight != nil {
                self.newsTextLabel?.attributedText = NSMutableAttributedString(string: text)
                self.newsTextLabel?.numberOfLines = 0
                self.newsTextLabel?.frame = CGRect(x: 6, y: totalSpace + viewsHeight, width: (self.containerView?.bounds.size.width)! - 12, height: (post.isCompact ? post.compactTextlimit : post.textHeigh)!)
                viewsHeight += (newsTextLabel?.frame.size.height)!
                self.showFull?.frame = CGRect(x: 6, y: totalSpace + viewsHeight, width: (self.containerView?.bounds.size.width)! - 12, height: post.bottomViewHeigh)
                viewsHeight += (showFull?.frame.size.height)!
                self.showFull?.setTitle(post.isCompact ? "Показать полностью" : "Показать меньше", for: .normal)
                self.showFull?.setTitleColor(UIColor(red: 85/255, green: 140/255, blue: 202/255, alpha: 1), for: .normal)
                self.showFull?.backgroundColor = UIColor.clear
                
                self.showFull?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.showFull?.titleLabel?.textAlignment = .left
                self.showFull?.sizeToFit()
                totalSpace += 6
            }
            
            if post.linksArray.count > 0 {
                let attributedString = NSMutableAttributedString(string: text)
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
            }
            
            
        }
        
        if post.photos.count > 0 {
            self.photoView?.frame = CGRect(x: 0, y: totalSpace + viewsHeight, width: (self.containerView?.frame.size.width)!, height: post.totalPhotosHeigh!)
            self.photoView?.setup(photos: post.photos)
        }
        

        let postBottomViewPositionY = (self.containerView?.frame.height)! - post.bottomViewHeigh
        self.postBottomView?.frame = CGRect(x: 0, y: postBottomViewPositionY, width: (self.containerView?.bounds.size.width)!, height: post.bottomViewHeigh)
        self.postBottomView?.setup(likesCount: post.likesCount ?? 0, repostsCount: post.repostsCount ?? 0, commentsCount: post.commentsCount ?? 0, viewsCount: post.viewsCount ?? 0)
        
        
    }
    
    func updateContent (post: NewsFeedModel) {
        print("click show full post text: \(String(describing: post.postText)), post is compact \(post.isCompact)")
        let realTextHieght = post.isCompact ? post.compactTextlimit : post.textHeigh
        let postHeight = post.isCompact ? post.compactHeight : post.totalHeight
        
        var totalSpace: CGFloat = 12
        var viewsHeight: CGFloat = post.autorViewHeigh
//
        if var frame = containerView?.frame {
            frame.size.height = postHeight! - 12
            containerView?.frame = frame
        }
//
        if var frame = newsTextLabel?.frame {
            frame.size.height = realTextHieght!
            newsTextLabel?.frame = frame
//            if let text = post.postText, text.count > 0 {
//                 newsTextLabel?.attributedText = NSMutableAttributedString(string: text)
//            }
            viewsHeight += (newsTextLabel?.frame.size.height)!
        }
        
        if var frame = showFull?.frame {
            frame.origin.y = viewsHeight + totalSpace
            frame.size.height = post.showMoreButtonHeigh
            self.showFull?.frame = frame
            self.showFull?.setTitle(post.isCompact ? "Показать полностью" : "Показать меньше", for: .normal)
            self.showFull?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.showFull?.sizeToFit()
            totalSpace += 6
            viewsHeight += (showFull?.frame.size.height)!

        }
        
        if var frame = photoView?.frame {
            frame.origin.y = viewsHeight + totalSpace - 6 // Пока не знаю, где просчет. нужно искать
            self.photoView?.frame = frame
            
            if frame.size.height > 0 {
                totalSpace += 6
                viewsHeight += (photoView?.frame.size.height)!
            }
        }
        
        if var frame = postBottomView?.frame, let containerHeight = containerView?.bounds.size.height {
            frame.origin.y = containerHeight - post.bottomViewHeigh
            postBottomView?.frame = frame
        }
        
    }
    
    @objc func openLabelLink (_ recognizer: UITapGestureRecognizer) {
        if let label = self.newsTextLabel {
            var linkWasTapped: Bool = false
            for link in self.linksArray {
                if recognizer.didTapAttributedTextInLabel(label: label, inRange: link.range) {
                    linkWasTapped = true
                    self.delegate?.openLink(link: link.link, linkWasTapped: true, indexPath: self.indexPath!)
                    break
                }
            }
            if !linkWasTapped {
                self.delegate?.openLink(link: "", linkWasTapped: false, indexPath: self.indexPath!)
            }
            print(self.newsTextLabel.debugDescription)
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsTextLabel?.text = nil
        self.newsTextLabel?.gestureRecognizers?.removeAll()
        self.newsTextLabel?.attributedText = nil
        self.newsTextLabel = nil
        self.indexPath = nil
        self.postAuthorView?.reuse()
        self.postBottomView?.reuse()
        self.showFull?.titleLabel?.text = nil
        self.containerView?.frame = CGRect.zero
        self.photoView?.reuse()
        self.linksArray.removeAll()
        self.delegate = nil
        self.photoView = nil
        self.postAuthorView = nil

        self.containerView = nil
        
        self.postBottomView = nil
        self.showFull = nil
    }
    
//    deinit {
//        self.newsTextLabel?.gestureRecognizers?.removeAll()
//        self.indexPath = nil
//    }

}
