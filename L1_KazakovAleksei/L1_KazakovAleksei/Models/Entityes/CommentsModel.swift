//
//  CommentsModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 31/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation
import UIKit

class CommentsModel {
    
    var commentText: String?
    
    var userAuthor: Friend?
    var groupAuthor: Public?
    
    public let postAuthorAvatarHeight: CGFloat = 30
    public var textHeight: CGFloat?
    
    public var totalHeight: CGFloat?
    
    public func calculateSize () {
        var height: CGFloat = 38
        if let text = self.commentText {
            self.textHeight = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 45, font: UIFont.systemFont(ofSize: 15))
            height += self.textHeight!
        }
        
        if height > 48 {
            self.totalHeight = height
        } else {
            self.totalHeight = 48
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
}
