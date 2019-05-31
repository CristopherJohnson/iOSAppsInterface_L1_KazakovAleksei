//
//  PostAuthorView.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class PostAuthorView: UIView {

    private weak var authorImageView: UIImageView?
    private weak var authorLabel: UILabel?
    private weak var dateLabel: UILabel?
    
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
    
    private func addSubviews () {
        if self.authorImageView == nil {
            let imageView = UIImageView()
            self.addSubview(imageView)
            self.authorImageView = imageView
        }
        
        if self.authorLabel == nil {
            let label = UILabel()
            self.addSubview(label)
            label.textAlignment = .left
            self.authorLabel = label
        }
        if self.dateLabel == nil {
            let label = UILabel()
            label.font = UIFont(name: "System", size: 12)
            label.textAlignment = .left
            self.addSubview(label)
            self.dateLabel = label
        }
    }
    
    public func setup (imageUrl: String, authorName: String, date: Date?) {
        ImageService.shared.get(urlString: imageUrl) { (image: UIImage?) in
            if let loadedImage = image {
                self.authorImageView?.image = loadedImage
            } else {
                print("post author Image loading error")
            }
        }
//        self.authorImageView?.load(url: URL(string: imageUrl)!)
        self.authorLabel?.text = authorName
        if let postDate = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM в HH:mm"
            formatter.locale = Locale(identifier: "ru")
            self.dateLabel?.text = formatter.string(from: postDate)
        } else {
            self.dateLabel?.text = "Date error"
        }
        
    }
    
    public func reuse () {
        self.authorImageView?.image = nil
        self.authorLabel?.text = nil
        self.dateLabel?.text = nil
    }
    
    //MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.authorImageView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.height, height: self.bounds.size.height)
        self.authorImageView?.layer.cornerRadius = self.bounds.height / 2
        self.authorImageView?.layer.masksToBounds = true
        
        let labelX: CGFloat = (self.authorImageView?.frame.size.width)! + 3
        let labelWidth: CGFloat = self.frame.size.width - labelX
        
        self.authorLabel?.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: (self.frame.size.height / 2))
//        self.authorLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.dateLabel?.frame = CGRect(x: labelX, y: (self.frame.size.height / 2), width: labelWidth, height: (self.frame.size.height / 2))
        self.dateLabel?.font = UIFont.systemFont(ofSize: 15)
        
    }
}
