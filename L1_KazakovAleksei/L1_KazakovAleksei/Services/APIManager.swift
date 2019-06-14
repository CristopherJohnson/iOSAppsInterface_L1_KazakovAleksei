//
//  APIManager.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation


protocol APIProtocol: class {
    func getFriends (complition: @escaping ([Friend]?)->())
    func getPublics (complition: @escaping ([Public]?)->())
    func getNewsFeedTypePost (startFrom: String?, complition: @escaping ([NewsFeedModel]?, String?, Error?)->())
    func getComments (ownerID: String, postID: String, complition: @escaping ([CommentsModel]?, Error?)->())
}



public class APIManager {
    private init () {}
    
    static let shared: APIProtocol = URLSessionAPIManager()
}


private class URLSessionAPIManager: APIProtocol {
    
    
    
    var urlSession: URLSession?
    var requestData = RequestData()
    
    init () {
        let configuration = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: configuration)
    }
    
    
    func getFriends(complition: @escaping ([Friend]?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let getFriendsListDataTask = self.urlSession?.dataTask(with: self.requestData.generateRequestToGetFriensList()!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                var friends: [Friend] = []
                let getFriendsResponse: GetFriends? = Parser.parseFriends(data: responseData)
                if let items = getFriendsResponse?.response.items {
                    for item in items {
                        let friend = Friend()
                        friend.id = item.id
                        friend.firstName = item.first_name
                        friend.lastName = item.last_name
                        friend.imageURL = item.photo_100
                        friends.append(friend)
                    }
                }
                complition(friends)
            } else {
               complition(nil)
            }
        }
        getFriendsListDataTask?.resume()
        }
    }
    
    func getPublics(complition: @escaping ([Public]?) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let getGroupsListDataTask = self.urlSession?.dataTask(with: self.requestData.generateRequestToGetGroups()!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                var publics: [Public] = []
                let getGroupsResponse: GetGroups? = Parser.parseGroups(data: responseData)
                if let items = getGroupsResponse?.response.items {
                    for item in items {
                        let publ = Public()
                        publ.id = item.id
                        publ.name = item.name
                        publ.imageURL = item.photo_200
                        publics.append(publ)
                    }
                }
                complition(publics)
            } else {
                complition(nil)
            }
            
        }
        getGroupsListDataTask?.resume()
        }
    }
    
    func getNewsFeedTypePost (startFrom: String?, complition: @escaping ([NewsFeedModel]?, String?, Error?)->()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let getNewsFeedTypePostDataTask = self.urlSession?.dataTask(with: self.requestData.generateRequestToGetNewsFeed(startFrom: startFrom)!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let responseData = data {
                    
                    var newsPosts: [NewsFeedModel] = []
                    
                    let getNewsFeedTypePostResponse: GetNewsFeedTypePost? = Parser.parseNewsFeed(data: responseData)
                    let nexFrom = getNewsFeedTypePostResponse?.response.next_from
                    if let items = getNewsFeedTypePostResponse?.response.items {
                        
                        for item in items {
                            let post = NewsFeedModel()
                            
                            post.date = Date(timeIntervalSince1970: item.date)
                            post.postId = item.post_id
                            
                            if item.text.count > 0 {
                                post.postText = item.text
                            }
                            
                            if item.marked_as_ads == 0{
                                post.isAdd = false
                            } else if item.marked_as_ads == 1 {
                                post.isAdd = true
                            }
                            
                            post.commentsCount = item.comments.count
                            
                            if item.comments.can_post == 0 {
                                post.canPostComments = false
                            } else if item.comments.can_post == 1 {
                                post.canPostComments = true
                            }
                            
                            post.likesCount = item.likes.count
                            
                            if item.likes.user_likes == 0 {
                                post.isLiked = false
                            } else if item.likes.user_likes == 1 {
                                post.isLiked = true
                            }
                            
                            if item.likes.can_like == 0 {
                                post.canLike = false
                            } else if item.likes.can_like == 1 {
                                post.canLike = true
                            }
                            
                            if item.likes.can_publish == 0 {
                                post.canMakeRepost = false
                            } else if item.likes.can_publish == 1 {
                                post.canMakeRepost = true
                            }
                            
                            post.repostsCount = item.reposts.count
                            
                            if item.reposts.user_reposted == 0 {
                                post.userReposted = false
                            } else if item.reposts.user_reposted == 1 {
                                 post.userReposted = true
                            }
                            
                            post.viewsCount = item.views.count
                            
                            if let attachments = item.attachments {
                                for attachment in attachments {
                                    guard let newsPhoto = attachment.photo else { continue }
                                    let photo = PhotoModel()
                                    photo.albumId = newsPhoto.album_id
                                    photo.date = Date(timeIntervalSince1970: newsPhoto.date)
                                    photo.id = newsPhoto.id
                                    photo.ownerId = newsPhoto.owner_id
                                    photo.userId = newsPhoto.user_id
                                    if newsPhoto.text.count > 0 {
                                        photo.text = newsPhoto.text
                                    }
                                    
                                    photo.cellSizeUrl = newsPhoto.getSize(size: .cellSize)?.url
                                    photo.detailSizeUrl = newsPhoto.getSize(size: .detailSize)?.url
                                    post.photos.append(photo)
                                }
                            }
                            post.sourceId = item.source_id
                            if item.source_id > 0, let profiles = getNewsFeedTypePostResponse?.response.profiles {
                                for profile in profiles {
                                    if profile.id == item.source_id {
                                        let friend = Friend()
                                        friend.id = profile.id
                                        friend.imageURL = profile.photo_100
                                        friend.firstName = profile.first_name
                                        friend.lastName = profile.last_name
                                        post.userAuthor = friend
                                    }
                                }
                            } else if item.source_id < 0, let groups = getNewsFeedTypePostResponse?.response.groups {
                                for group in groups {
                                    if abs(item.source_id) == group.id {
                                        let groupModel = Public()
                                        groupModel.id = group.id
                                        groupModel.imageURL = group.photo_100
                                        groupModel.name = group.name
                                        post.groupAuthor = groupModel
                                    }
                                }
                            }
                            post.calculateSize()
                            post.searchForLinks()
                            newsPosts.append(post)
                        }
                    }
                    DispatchQueue.main.async {
                        complition(newsPosts, nexFrom, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                       complition(nil, nil, error)
                    }
                }
            })
            getNewsFeedTypePostDataTask?.resume()
        }
        
        
    }
    
    func getComments(ownerID: String, postID: String, complition: @escaping ([CommentsModel]?, Error?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let getCommentsDataTask = self.urlSession?.dataTask(with: self.requestData.generateRequestToGetComments(ownerID: ownerID, postID: postID)!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let responseData = data {
                    var commentsArray: [CommentsModel] = []
                    
                    let getCommentsResponse: GetWallComents? = Parser.parseComments(data: responseData)
                    
                    if let items = getCommentsResponse?.response.items {
                        for item in items {
                            let comment = CommentsModel()
                            
                            comment.currentComment.commetnId = item.id
                            comment.currentComment.authorId = item.from_id
                            comment.currentComment.postId = item.post_id
                            comment.currentComment.ownerId = item.post_id
                            
                            comment.currentComment.parentsStack = item.parents_stack
                            comment.currentComment.date = Date(timeIntervalSince1970: item.date)
                            
                            
                            if let text = item.text, text.count > 0 {
                                comment.currentComment.commentText = text
                            }
                            
                            comment.currentComment.likesCount = item.likes.count
                            
                            if item.likes.can_like == 0 {
                                comment.currentComment.canLike = false
                            } else if item.likes.can_like == 1 {
                                comment.currentComment.canLike = true
                            }
                            
                            if item.likes.can_like == 0 {
                                comment.currentComment.canLike = false
                            } else if item.likes.can_like == 1 {
                                comment.currentComment.canLike = true
                            }
                            
                            if let attachments = item.attachments {
                                for attachment in attachments {
                                    guard let commentPhoto = attachment.photo else { continue }
                                    let photo = PhotoModel()
                                    photo.albumId = commentPhoto.album_id
                                    photo.date = Date(timeIntervalSince1970: commentPhoto.date)
                                    photo.id = commentPhoto.id
                                    photo.ownerId = commentPhoto.owner_id
                                    if commentPhoto.text.count > 0 {
                                        photo.text = commentPhoto.text
                                    }
                                    
                                    photo.cellSizeUrl = commentPhoto.getSize(size: .cellSize)?.url
                                    photo.detailSizeUrl = commentPhoto.getSize(size: .detailSize)?.url
                                    comment.currentComment.photos.append(photo)
                                }
                            }
                            
                            if item.from_id > 0, let profiles = getCommentsResponse?.response.profiles {
                                for profile in profiles {
                                    if profile.id == item.from_id {
                                        let friend = Friend()
                                        friend.id = profile.id
                                        friend.imageURL = profile.photo_100
                                        friend.firstName = profile.first_name
                                        friend.lastName = profile.last_name
                                        comment.currentComment.userAuthor = friend
                                    }
                                }
                            } else if item.from_id < 0, let groups = getCommentsResponse?.response.groups {
                                for group in groups {
                                    if abs(item.from_id) == group.id {
                                        let groupModel = Public()
                                        groupModel.id = group.id
                                        groupModel.imageURL = group.photo_100
                                        groupModel.name = group.name
                                        comment.currentComment.groupAuthor = groupModel
                                    }
                                }
                            }
                            
                            
                            comment.threadCount = item.thread?.count
                            print(comment.threadCount, item.thread?.count)
                            comment.threadCanPost = item.thread?.can_post
                            comment.threadShowReplyButton = item.thread?.show_reply_button
                            comment.threadGroupsCanPost = item.thread?.groups_can_post
                            
                            if let threadItems = item.thread?.items, threadItems.count > 0 {
                                for threadItem in threadItems {
                                    let commentItemModel = CommentsItemModel()
                                    commentItemModel.commetnId = threadItem.id
                                    commentItemModel.authorId = threadItem.from_id
                                    commentItemModel.postId = threadItem.post_id
                                    commentItemModel.ownerId = threadItem.post_id
                                    
                                    commentItemModel.parentsStack = threadItem.parents_stack
                                    commentItemModel.date = Date(timeIntervalSince1970: threadItem.date)
                                    
                                    
                                    if let text = threadItem.text, text.count > 0 {
                                        commentItemModel.commentText = text
                                    }
                                    
                                    commentItemModel.likesCount = threadItem.likes.count
                                    
                                    if threadItem.likes.can_like == 0 {
                                        commentItemModel.canLike = false
                                    } else if threadItem.likes.can_like == 1 {
                                        commentItemModel.canLike = true
                                    }
                                    
                                    if threadItem.likes.can_like == 0 {
                                        commentItemModel.canLike = false
                                    } else if threadItem.likes.can_like == 1 {
                                        commentItemModel.canLike = true
                                    }
                                    
                                    if let attachments = threadItem.attachments {
                                        for attachment in attachments {
                                            guard let commentPhoto = attachment.photo else { continue }
                                            let photo = PhotoModel()
                                            photo.albumId = commentPhoto.album_id
                                            photo.date = Date(timeIntervalSince1970: commentPhoto.date)
                                            photo.id = commentPhoto.id
                                            photo.ownerId = commentPhoto.owner_id
                                            if commentPhoto.text.count > 0 {
                                                photo.text = commentPhoto.text
                                            }
                                            
                                            photo.cellSizeUrl = commentPhoto.getSize(size: .cellSize)?.url
                                            photo.detailSizeUrl = commentPhoto.getSize(size: .detailSize)?.url
                                            commentItemModel.photos.append(photo)
                                        }
                                    }
                                    
                                    if threadItem.from_id > 0, let profiles = getCommentsResponse?.response.profiles {
                                        for profile in profiles {
                                            if profile.id == threadItem.from_id {
                                                let friend = Friend()
                                                friend.id = profile.id
                                                friend.imageURL = profile.photo_100
                                                friend.firstName = profile.first_name
                                                friend.lastName = profile.last_name
                                                commentItemModel.userAuthor = friend
                                            }
                                        }
                                    } else if threadItem.from_id < 0, let groups = getCommentsResponse?.response.groups {
                                        for group in groups {
                                            if abs(threadItem.from_id) == group.id {
                                                let groupModel = Public()
                                                groupModel.id = group.id
                                                groupModel.imageURL = group.photo_100
                                                groupModel.name = group.name
                                                commentItemModel.groupAuthor = groupModel
                                            }
                                        }
                                    }
                                    comment.threadComments.append(commentItemModel)
                                }
                            }
                            
                            comment.calculateSize()
                            commentsArray.append(comment)
                        }
                    }
                    DispatchQueue.main.async {
                        complition(commentsArray, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        complition(nil, error)
                    }
                }
            })
            getCommentsDataTask?.resume()
        }
    }
 
}
