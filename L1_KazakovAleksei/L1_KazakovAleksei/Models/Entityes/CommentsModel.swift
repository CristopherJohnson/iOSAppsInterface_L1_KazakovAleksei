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
        var height: CGFloat = 32
        if let text = self.commentText {
            self.textHeight = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 48, font: UIFont.systemFont(ofSize: 15))
            height += self.textHeight!
        }
        
        if height > 42 {
            self.totalHeight = height
        } else {
            self.totalHeight = 42
        }
    }
}
