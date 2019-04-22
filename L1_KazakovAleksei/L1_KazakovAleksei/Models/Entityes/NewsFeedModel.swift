//
//  NewsFeedModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

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
}
