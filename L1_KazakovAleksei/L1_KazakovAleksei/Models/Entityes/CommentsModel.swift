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
    

    var currentComment = CommentsItemModel()
    var threadCount: Int?
    var threadComments: [CommentsItemModel] = []
    var threadCanPost: Bool?
    var threadShowReplyButton: Bool?
    var threadGroupsCanPost: Bool?
    
    public let postAuthorAvatarHeight: CGFloat = 30
    public var textHeight: CGFloat?
    
    public var totalHeight: CGFloat?
    
    private var totalSpace: CGFloat = 12 // отступы контент вью от верха и низа ячейки
    
    public func calculateSize () {
        self.totalHeight = 0
        self.totalSpace += 12 + (6 * CGFloat(self.threadComments.count) * 2) + (self.threadCount ?? 0 > 3 ? 12 : 0) // отступы сверху и снизу для вью главного комментария + отступы для ответов + отступ для кнопки показать все комментарии
        self.totalHeight! += totalSpace
        self.currentComment.commentViewHeihgt += 46
        if let text = self.currentComment.commentText {
            self.currentComment.commentTextHeight = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 48, font: UIFont.systemFont(ofSize: 15))
            self.currentComment.commentViewHeihgt += self.currentComment.commentTextHeight!
        } else {
            self.currentComment.commentViewHeihgt += 10
        }
        self.totalHeight! += self.currentComment.commentViewHeihgt
        if self.threadComments.count > 0 {
            for comment in self.threadComments {
                comment.commentViewHeihgt += 46
                if let text = comment.commentText {
                    comment.commentTextHeight = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 48 - 27 - 6, font: UIFont.systemFont(ofSize: 15))
                    comment.commentViewHeihgt += comment.commentTextHeight!
                } else {
                    comment.commentViewHeihgt += 7
                }
                self.totalHeight! += comment.commentViewHeihgt
            }
        }
    }
    
    
}
