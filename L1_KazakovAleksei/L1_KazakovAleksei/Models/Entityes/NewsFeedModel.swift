//
//  NewsFeedModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedModel {
    var date: Date?
    var postText: String?
    var isAdd: Bool?
    var postId: Int?
    
    var commentsCount: Int?
    var canPostComments: Bool?
    
    var likesCount: Int?
    var isLiked: Bool?
    var canLike: Bool?
    var canMakeRepost: Bool?
    
    var repostsCount: Int?
    var userReposted: Bool?
    
    var viewsCount: Int?
    
    var photos: [PhotoModel] = []
    
    var userAuthor: Friend?
    var groupAuthor: Public?
    
    var totalHeight: CGFloat?
    var textHeigh: CGFloat?
    var compactHeight: CGFloat?
    var totalPhotosHeigh: CGFloat?
    var isCompact = false
    let autorViewHeigh: CGFloat = 45
    let bottomViewHeigh: CGFloat = 25
    let compactTextlimit: CGFloat = 144
    let showMoreButtonHeigh: CGFloat = 22
    
    private let photoHeight = (UIScreen.main.bounds.size.width - 12) * 2 / 3
    private let photosPageControlHeight: CGFloat = 39
    private var totalSpace: CGFloat = 12
    private let spaceBetweenCells: CGFloat = 12
    
    public var postTextlinkURL: String?
    public var postTextLinkLocation: Int = 0
    public var postTextLinkLength: Int = 0
    
    
    public func calculateSize () {
        
        if let text = self.postText, text.count > 0 {
            self.textHeigh = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 24, font: UIFont.systemFont(ofSize: 17))
            if self.textHeigh! >= self.compactTextlimit {
                self.isCompact = true
            }
            self.totalSpace += 6
        }
        
        if self.photos.count > 0 && self.photos.count == 1 {
            self.totalPhotosHeigh = photoHeight
            self.totalSpace += 6
        } else if self.photos.count > 1 {
            self.totalPhotosHeigh = photoHeight + photosPageControlHeight
            self.totalSpace += 6
        }
        
        self.totalHeight = self.autorViewHeigh + self.bottomViewHeigh + self.totalSpace + self.spaceBetweenCells + (self.textHeigh ?? 0) + (self.isCompact ? self.showMoreButtonHeigh : 0) + (self.totalPhotosHeigh ?? 0)
        
        if self.isCompact == true {
            self.compactHeight = self.autorViewHeigh + self.bottomViewHeigh + self.totalSpace + self.spaceBetweenCells + self.compactTextlimit + self.showMoreButtonHeigh + (self.totalPhotosHeigh ?? 0)
        }
    }
    
    public func getAuthorName () -> String {
        if let user = self.userAuthor {
            return "\(user.firstName ?? "No firstName") \(user.lastName ?? "No lastName")"
        } else if let group = self.groupAuthor {
            return "\(group.name ?? "No groupName")"
        }
        return "No authror Name"
    }
    
    public func searchForLinks () {
        if let text = self.postText, text.count > 0 {
            let input = text
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
            
            for match in matches {
                guard let range = Range(match.range, in: input) else { continue }
                let url = input[range]
                print(url)
                print(match.range)
            }
//            let textArray = text.components(separatedBy: " ")
//            for word in  textArray {
//                if word.contains("http://") || word.contains("https://") {
//                    self.postTextlinkURL = word
//                    self.postTextLinkLength = word.count
//                    print(word)
//                    print(postTextLinkLocation)
//                    break
//                } else {
//                    self.postTextLinkLocation += word.count + 1
//                }
//            }
        }
    }
}

