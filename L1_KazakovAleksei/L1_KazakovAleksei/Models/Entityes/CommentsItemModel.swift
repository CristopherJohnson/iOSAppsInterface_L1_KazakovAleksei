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
    
    public func getAuthorName () -> String {
        if let user = self.userAuthor {
            return "\(user.firstName ?? "No firstName") \(user.lastName ?? "No lastName")"
        } else if let group = self.groupAuthor {
            return "\(group.name ?? "No groupName")"
        }
        return "No authror Name"
    }
}
