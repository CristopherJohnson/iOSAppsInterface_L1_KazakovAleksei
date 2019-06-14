//
//  Parser.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 15/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

enum PrefferredSize {
    case cellSize
    case detailSize
}


class Parser {
    static func parseGroups (data: Data?) -> GetGroups? {
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let response: GetGroups = try decoder.decode(GetGroups.self, from: data)
            return response
        } catch {
            print("JSONDecoder exception \(#file) \(#function) \(#line) \(error)")
        }
        
        return nil
    }
    
    static func parseFriends (data: Data?) -> GetFriends? {
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let response: GetFriends = try decoder.decode(GetFriends.self, from: data)
            print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
            return response
        } catch {
            print("JSONDecoder exception \(#file) \(#function) \(#line) \(error)")
        }
        
        return nil
    }
    
    static func parseNewsFeed (data: Data?) -> GetNewsFeedTypePost? {
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let response: GetNewsFeedTypePost = try decoder.decode(GetNewsFeedTypePost.self, from: data)
            print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
            return response
        } catch {
            print("JSONDecoder exception \(#file) \(#function) \(#line) \(error)")
        }
        
        return nil
    }
    
    static func parseComments (data: Data?) -> GetWallComents? {
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let response: GetWallComents = try decoder.decode(GetWallComents.self, from: data)
            print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
            return response
        } catch {
            print("JSONDecoder exception \(#file) \(#function) \(#line) \(error)")
        }
        
        return nil
    }
}


class GetGroups: Codable {
    var response: GetGroupsResponse
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(response, forKey: .response)
    }
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(GetGroupsResponse.self, forKey: .response)
    }
    
}

class GetGroupsResponse: Codable {
    var items: [GetGroupsResponseItems] = []
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([GetGroupsResponseItems].self, forKey: .items)
    }
}

class  GetGroupsResponseItems: Codable {
    var id: Int
    var name: String
    var photo_50: String
    var photo_100: String
    var photo_200: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_50
        case photo_100
        case photo_200
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(photo_50, forKey: .photo_50)
        try container.encode(photo_100, forKey: .photo_100)
        try container.encode(photo_200, forKey: .photo_200)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photo_50 = try container.decode(String.self, forKey: .photo_50)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
        photo_200 = try container.decode(String.self, forKey: .photo_200)
    }
}


class GetFriends: Codable {
    var response: GetFriendsResponse
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(response, forKey: .response)
    }
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(GetFriendsResponse.self, forKey: .response)
    }
    
}

class GetFriendsResponse: Codable {
    var items: [GetFriendsResponseItems] = []
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([GetFriendsResponseItems].self, forKey: .items)
    }
}

class  GetFriendsResponseItems: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo_100
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(first_name, forKey: .first_name)
        try container.encode(last_name, forKey: .last_name)
        try container.encode(photo_100, forKey: .photo_100)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
    }
}


class GetNewsFeedTypePost: Codable {
    var response: GetNewsFeedTypePostResponse
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(response, forKey: .response)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(GetNewsFeedTypePostResponse.self, forKey: .response)
    }
}

class GetNewsFeedTypePostResponse: Codable {
    
    var items: [GetNewsFeedTypePostResponseItems] = []
    var profiles: [GetNewsFeedTypePostResponseProfiles] = []
    var groups: [GetNewsFeedTypePostResponseGroups] = []
    var next_from: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case next_from
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
        try container.encode(profiles, forKey: .profiles)
        try container.encode(groups, forKey: .groups)
        try container.encode(next_from, forKey: .next_from)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([GetNewsFeedTypePostResponseItems].self, forKey: .items)
        profiles = try container.decode([GetNewsFeedTypePostResponseProfiles].self, forKey: .profiles)
        groups = try container.decode([GetNewsFeedTypePostResponseGroups].self, forKey: .groups)
        next_from = try container.decode(String.self, forKey: .next_from)
    }
    
}

class GetNewsFeedTypePostResponseItems: Codable {
    var type: String
    var source_id: Int
    var date: TimeInterval
    var text: String
    var marked_as_ads: Int?
    var attachments: [GetNewsFeedTypePostResponseItemsAttachments]?
    var comments: GetNewsFeedTypePostResponseItemsComents
    var likes: GetNewsFeedTypePostResponseItemsLikes
    var reposts: GetNewsFeedTypePostResponseItemsReposts
    var views: GetNewsFeedTypePostResponseItemsViews
    var is_favorite: Bool
    var post_id: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case source_id
        case date
        case text
        case marked_as_ads
        case attachments
        case comments
        case likes
        case reposts
        case views
        case is_favorite
        case post_id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(source_id, forKey: .source_id)
        try container.encode(date, forKey: .date)
        try container.encode(text, forKey: .text)
        try? container.encode(marked_as_ads, forKey: .marked_as_ads)
        try? container.encode(attachments, forKey: .attachments)
        try container.encode(comments, forKey: .comments)
        try container.encode(likes, forKey: .likes)
        try container.encode(reposts, forKey: .reposts)
        try container.encode(views, forKey: .views)
        try container.encode(is_favorite, forKey: .is_favorite)
        try container.encode(post_id, forKey: .post_id)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        source_id = try container.decode(Int.self, forKey: .source_id)
        date = try container.decode(TimeInterval.self, forKey: .date)
        text = try container.decode(String.self, forKey: .text)
        marked_as_ads = try? container.decode(Int.self, forKey: .marked_as_ads)
        attachments = try? container.decode([GetNewsFeedTypePostResponseItemsAttachments].self, forKey: .attachments)
        comments = try container.decode(GetNewsFeedTypePostResponseItemsComents.self, forKey: .comments)
        likes = try container.decode(GetNewsFeedTypePostResponseItemsLikes.self, forKey: .likes)
        reposts = try container.decode(GetNewsFeedTypePostResponseItemsReposts.self, forKey: .reposts)
        views = try container.decode(GetNewsFeedTypePostResponseItemsViews.self, forKey: .views)
        is_favorite = try container.decode(Bool.self, forKey: .is_favorite)
        post_id = try container.decode(Int.self, forKey: .post_id)
    }
    
    
}

class GetNewsFeedTypePostResponseItemsAttachments: Codable {
    var type: String
    var photo: GetNewsFeedTypePostResponseItemsAttachmentsPhoto?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try? container.encode(photo, forKey: .photo)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        photo = try? container.decode(GetNewsFeedTypePostResponseItemsAttachmentsPhoto.self, forKey: .photo)
    }
}

class GetNewsFeedTypePostResponseItemsAttachmentsPhoto: Codable {
    var id: Int
    var album_id: Int
    var owner_id: Int
    var user_id: Int
    var sizes: [GetNewsFeedTypePostResponseItemsAttachmentsPhotoSizes] = []
    var text: String
    var date: TimeInterval
    var access_key: String
    
    private var sizesDictionary: [String : GetNewsFeedTypePostResponseItemsAttachmentsPhotoSizes] = [:]
    
    enum CodingKeys: String, CodingKey {
        case id
        case album_id
        case owner_id
        case user_id
        case sizes
        case text
        case date
        case access_key
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(album_id, forKey: .album_id)
        try container.encode(owner_id, forKey: .owner_id)
        try container.encode(user_id, forKey: .user_id)
        try container.encode(sizes, forKey: .sizes)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
        try container.encode(access_key, forKey: .access_key)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        album_id = try container.decode(Int.self, forKey: .album_id)
        owner_id = try container.decode(Int.self, forKey: .owner_id)
        user_id = try container.decode(Int.self, forKey: .user_id)
        sizes = try container.decode([GetNewsFeedTypePostResponseItemsAttachmentsPhotoSizes].self, forKey: .sizes)
        text = try container.decode(String.self, forKey: .text)
        date = try container.decode(TimeInterval.self, forKey: .date)
        access_key = try container.decode(String.self, forKey: .access_key)
        
        for size in self.sizes {
            self.sizesDictionary[size.type] = size
        }
    }
    
    func getSize (size: PrefferredSize) -> GetNewsFeedTypePostResponseItemsAttachmentsPhotoSizes? {
        if self.sizes.count <= 0 {
            return nil
        }
        
        var priorities: [String] = ["x", "m", "s", "o", "p", "q", "r", "y", "z", "w"]
        
        switch size {
        case .cellSize:
            break
        case .detailSize:
            priorities = ["w", "z", "y", "x", "r", "q", "p", "o", "m", "s"]
            break
        }
        
        for currentPriority in priorities {
            if let size = self.sizesDictionary[currentPriority] {
                return size
            }
        }
        
        return nil
    }
    
}

class GetNewsFeedTypePostResponseItemsAttachmentsPhotoSizes: Codable {
    var type: String
    var url: String
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case width
        case height
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(url, forKey: .url)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
}

class GetNewsFeedTypePostResponseItemsComents: Codable {
    var count: Int
    var can_post: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case can_post
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(can_post, forKey: .can_post)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        can_post = try container.decode(Int.self, forKey: .can_post)
    }
}

class GetNewsFeedTypePostResponseItemsLikes: Codable {
    var count: Int
    var user_likes: Int
    var can_like: Int
    var can_publish: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case user_likes
        case can_like
        case can_publish
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(user_likes, forKey: .user_likes)
        try container.encode(can_like, forKey: .can_like)
        try container.encode(can_publish, forKey: .can_publish)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        user_likes = try container.decode(Int.self, forKey: .user_likes)
        can_like = try container.decode(Int.self, forKey: .can_like)
        can_publish = try container.decode(Int.self, forKey: .can_publish)
    }
}

class GetNewsFeedTypePostResponseItemsReposts: Codable {
    var count: Int
    var user_reposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case user_reposted
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(user_reposted, forKey: .user_reposted)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        user_reposted = try container.decode(Int.self, forKey: .user_reposted)
    }
}

class GetNewsFeedTypePostResponseItemsViews: Codable {
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
    }
}

class GetNewsFeedTypePostResponseGroups: Codable {
    var id: Int
    var name: String
    var photo_100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_100
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(photo_100, forKey: .photo_100)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
    }
}

class GetNewsFeedTypePostResponseProfiles: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo_100
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(first_name, forKey: .first_name)
        try container.encode(last_name, forKey: .last_name)
        try container.encode(photo_100, forKey: .photo_100)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
    }
}

class GetWallComents: Codable {
    
    var response: GetWallComentsResponse
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(response, forKey: .response)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(GetWallComentsResponse.self, forKey: .response)
    }
}

class GetWallComentsResponse: Codable {
    var count: Int
    var items: [GetWallComentsResponseItems] = []
    var profiles: [GetWallComentsResponseProfiles] = []
    var groups: [GetWallComentsResponseGroups] = []
    var current_level_count: Int
    var can_post: Bool
    var show_reply_button: Bool
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
        case profiles
        case groups
        case current_level_count
        case can_post
        case show_reply_button
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(items, forKey: .items)
        try container.encode(profiles, forKey: .profiles)
        try container.encode(groups, forKey: .groups)
        try container.encode(current_level_count, forKey: .current_level_count)
        try container.encode(can_post, forKey: .can_post)
        try container.encode(show_reply_button, forKey: .show_reply_button)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        items = try container.decode([GetWallComentsResponseItems].self, forKey: .items)
        profiles = try container.decode([GetWallComentsResponseProfiles].self, forKey: .profiles)
        groups = try container.decode([GetWallComentsResponseGroups].self, forKey: .groups)
        current_level_count = try container.decode(Int.self, forKey: .current_level_count)
        can_post = try container.decode(Bool.self, forKey: .can_post)
        show_reply_button = try container.decode(Bool.self, forKey: .show_reply_button)
    }
}

class GetWallComentsResponseItems: Codable {
    
    var id: Int
    var from_id: Int
    var post_id: Int
    var owner_id: Int
    var parents_stack: [Int] = []
    var date: TimeInterval
    var text: String?
    var likes: GetWallComentsResponseItemsLikes
    var attachments: [GetWallComentsResponseItemsAttachments]?
    var thread: GetWallComentsResponseItemsThread?
    var reply_to_user: Int?
    var reply_to_comment: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case from_id
        case post_id
        case owner_id
        case parents_stack
        case date
        case text
        case likes
        case attachments
        case thread
        case reply_to_user
        case reply_to_comment
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(from_id, forKey: .from_id)
        try container.encode(post_id, forKey: .post_id)
        try container.encode(owner_id, forKey: .owner_id)
        try container.encode(parents_stack, forKey: .parents_stack)
        try container.encode(date, forKey: .date)
        try? container.encode(text, forKey: .text)
        try container.encode(likes, forKey: .likes)
        try? container.encode(attachments, forKey: .attachments)
        try? container.encode(thread, forKey: .thread)
        try? container.encode(reply_to_user, forKey: .reply_to_user)
        try? container.encode(reply_to_comment, forKey: .reply_to_comment)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        from_id = try container.decode(Int.self, forKey: .from_id)
        post_id = try container.decode(Int.self, forKey: .post_id)
        owner_id = try container.decode(Int.self, forKey: .owner_id)
        parents_stack = try container.decode([Int].self, forKey: .parents_stack)
        date = try container.decode(TimeInterval.self, forKey: .date)
        text = try? container.decode(String.self, forKey: .text)
        likes = try container.decode(GetWallComentsResponseItemsLikes.self, forKey: .likes)
        attachments = try? container.decode([GetWallComentsResponseItemsAttachments].self, forKey: .attachments)
        thread = try? container.decode(GetWallComentsResponseItemsThread.self, forKey: .thread)
        reply_to_user = try? container.decode(Int.self, forKey: .reply_to_user)
        reply_to_comment = try? container.decode(Int.self, forKey: .reply_to_comment)
    }
    
}

class GetWallComentsResponseItemsLikes: Codable {
    
    var count: Int
    var user_likes: Int
    var can_like: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case user_likes
        case can_like
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(user_likes, forKey: .user_likes)
        try container.encode(can_like, forKey: .can_like)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        user_likes = try container.decode(Int.self, forKey: .user_likes)
        can_like = try container.decode(Int.self, forKey: .can_like)
    }
}

class GetWallComentsResponseItemsAttachments: Codable {
    
    var type: String
    var photo: GetWallComentsResponseItemsAttachmentsPhoto?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try? container.encode(photo, forKey: .photo)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        photo = try? container.decode(GetWallComentsResponseItemsAttachmentsPhoto.self, forKey: .photo)
    }
}

class GetWallComentsResponseItemsAttachmentsPhoto: Codable {
    var id: Int
    var album_id: Int
    var owner_id: Int
    var sizes: [GetWallComentsResponseItemsAttachmentsPhotoSizes] = []
    var text: String
    var date: TimeInterval
    var access_key: String
    
    private var sizesDictionary: [String : GetWallComentsResponseItemsAttachmentsPhotoSizes] = [:]
    
    enum CodingKeys: String, CodingKey {
        case id
        case album_id
        case owner_id
        case sizes
        case text
        case date
        case access_key
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(album_id, forKey: .album_id)
        try container.encode(owner_id, forKey: .owner_id)
        try container.encode(sizes, forKey: .sizes)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
        try container.encode(access_key, forKey: .access_key)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        album_id = try container.decode(Int.self, forKey: .album_id)
        owner_id = try container.decode(Int.self, forKey: .owner_id)
        sizes = try container.decode([GetWallComentsResponseItemsAttachmentsPhotoSizes].self, forKey: .sizes)
        text = try container.decode(String.self, forKey: .text)
        date = try container.decode(TimeInterval.self, forKey: .date)
        access_key = try container.decode(String.self, forKey: .access_key)
        
        for size in self.sizes {
            self.sizesDictionary[size.type] = size
        }
    }
    
    func getSize (size: PrefferredSize) -> GetWallComentsResponseItemsAttachmentsPhotoSizes? {
        if self.sizes.count <= 0 {
            return nil
        }
        
        var priorities: [String] = ["x", "m", "s", "o", "p", "q", "r", "y", "z", "w"]
        
        switch size {
        case .cellSize:
            break
        case .detailSize:
            priorities = ["w", "z", "y", "x", "r", "q", "p", "o", "m", "s"]
            break
        }
        
        for currentPriority in priorities {
            if let size = self.sizesDictionary[currentPriority] {
                return size
            }
        }
        
        return nil
    }
}

class GetWallComentsResponseItemsAttachmentsPhotoSizes: Codable {
    var type: String
    var url: String
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case width
        case height
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(url, forKey: .url)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
}

class GetWallComentsResponseItemsThread: Codable {
    
    var count: Int
    var items: [GetWallComentsResponseItems] = []
    var can_post: Bool
    var show_reply_button: Bool
    var groups_can_post: Bool
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
        case can_post
        case show_reply_button
        case groups_can_post
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(items, forKey: .items)
        try container.encode(can_post, forKey: .can_post)
        try container.encode(show_reply_button, forKey: .show_reply_button)
        try container.encode(groups_can_post, forKey: .groups_can_post)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        items = try container.decode([GetWallComentsResponseItems].self, forKey: .items)
        can_post = try container.decode(Bool.self, forKey: .can_post)
        show_reply_button = try container.decode(Bool.self, forKey: .show_reply_button)
        groups_can_post = try container.decode(Bool.self, forKey: .groups_can_post)
    }
}

class GetWallComentsResponseProfiles: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo_100
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(first_name, forKey: .first_name)
        try container.encode(last_name, forKey: .last_name)
        try container.encode(photo_100, forKey: .photo_100)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
    }
}

class GetWallComentsResponseGroups: Codable {
    var id: Int
    var name: String
    var photo_100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_100
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(photo_100, forKey: .photo_100)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photo_100 = try container.decode(String.self, forKey: .photo_100)
    }
}
