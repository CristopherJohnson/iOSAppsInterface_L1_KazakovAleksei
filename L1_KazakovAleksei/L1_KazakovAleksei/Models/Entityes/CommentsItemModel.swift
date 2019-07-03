//
//  CommentsItemModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 03/06/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation
import UIKit

class CommentsItemModel {
    var commetnId: Int?
    var authorId: Int?
    var postId: Int?
    var ownerId: Int?
    var parentsStack: [Int] = []
    var date: Date?
    var commentText: String?
    var photos: [PhotoModel] = []
    var userAuthor: Friend?
    var groupAuthor: Public?
    
    var likesCount: Int?
    var isLiked: Bool?
    var canLike: Bool?
    
    public var commentViewHeihgt: CGFloat = 0
    public var commentTextHeight: CGFloat?
    public var linksArray: [LinkModel] = []
    
    public func getAuthorName () -> String {
        if let user = self.userAuthor {
            return "\(user.firstName ?? "No firstName") \(user.lastName ?? "No lastName")"
        } else if let group = self.groupAuthor {
            return "\(group.name ?? "No groupName")"
        }
        return "No authror Name"
    }
    
    public func searchForLinks () {
        if let text = self.commentText, text.count > 0 {
            let links1 = self.matches(for: #"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+"# , in: text)
            for link in links1 {
                let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: link, options: [], range: NSRange(location: 0, length: link.utf16.count))
                for match in matches {
                    guard let range = Range(match.range, in: link) else { continue }
                    let url = link[range]
                    let nsStr = NSString(string: text)
                    let linkRange = nsStr.range(of: String(url))
                    print("detector url is \(String(describing: String(url))) in range \(linkRange)")
                    let model = LinkModel(link: String(url), range: linkRange)
                    self.linksArray.append(model)
                }
            }
//            let input = text
//            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//
//            for match in matches {
//                guard let range = Range(match.range, in: input) else { continue }
//                let url = input[range]
//                print("detector url is \(url) in range \(match.range)")
//            }
        }
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
