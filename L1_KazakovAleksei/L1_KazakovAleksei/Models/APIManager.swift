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
    func getNewsFeedTypePost ()
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
        let getFriendsListDataTask = urlSession?.dataTask(with: self.requestData.generateRequestToGetFriensList()!) { (data: Data?, response: URLResponse?, error: Error?) in
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
            }
            complition(nil)
        }
        getFriendsListDataTask?.resume()
    }
    
    func getPublics(complition: @escaping ([Public]?) -> ()) {
        
        let getGroupsListDataTask = urlSession?.dataTask(with: self.requestData.generateRequestToGetGroups()!) { (data: Data?, response: URLResponse?, error: Error?) in
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
            }
            complition(nil)
        }
        getGroupsListDataTask?.resume()
    }
    
    func getNewsFeedTypePost () {
        let getNewsFeedTypePostDataTask = urlSession?.dataTask(with: self.requestData.generateRequestToGetNewsFeed()!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                var newsPosts: [NewsFeedModel] = []
                let getNewsFeedTypePostResponse: GetNewsFeedTypePost? = Parser.parseNewsFeed(data: responseData)
                if let items = getNewsFeedTypePostResponse?.response.items {
                    for item in items {
                        print("=======================NEW POST=====================")
                        let post = NewsFeedModel()
                        
                        post.date = Date(timeIntervalSince1970: item.date)
                        print("post.date \(String(describing: post.date))")
                        
                        if item.text.count > 0 {
                            post.postText = item.text
                            print("post.postText \(String(describing: post.postText))")
                        }
                        
                        if item.marked_as_ads == 0{
                            post.isAdd = false
                            print("post.isAdd \(String(describing: post.isAdd))")
                        } else if item.marked_as_ads == 1 {
                            post.isAdd = true
                            print("post.isAdd \(String(describing: post.isAdd))")
                        }
                        
                        post.commentsCount = item.comments.count
                        print("post.commentsCount \(String(describing: post.commentsCount))")
                        
                        if item.comments.can_post == 0 {
                            post.canPostComments = false
                            print("post.canPostComments \(String(describing: post.canPostComments))")
                        } else if item.comments.can_post == 1 {
                            post.canPostComments = true
                            print("post.commentsCount \(String(describing: post.commentsCount))")
                        }
                        
                        post.likesCount = item.likes.count
                        print("post.likesCount \(String(describing: post.likesCount))")
                        
                        if item.likes.user_likes == 0 {
                            post.isLiked = false
                            print("post.isLiked \(String(describing: post.isLiked))")
                        } else if item.likes.user_likes == 1 {
                            post.isLiked = true
                            print("post.isLiked \(String(describing: post.isLiked))")
                        }
                        
                        if item.likes.can_like == 0 {
                            post.canLike = false
                            print("post.canLike \(String(describing: post.canLike))")
                        } else if item.likes.can_like == 1 {
                            post.canLike = true
                            print("post.canLike \(String(describing: post.canLike))")
                        }
                        
                        if item.likes.can_publish == 0 {
                            post.canMakeRepost = false
                            print("post.canMakeRepost \(String(describing: post.canMakeRepost))")
                        } else if item.likes.can_publish == 1 {
                            post.canMakeRepost = true
                            print("post.canMakeRepost \(String(describing: post.canMakeRepost))")
                        }
                        
                        post.repostsCount = item.reposts.count
                        print("post.repostsCount \(String(describing: post.repostsCount))")
                        
                        if item.reposts.user_reposted == 0 {
                            post.userReposted = false
                            print("post.userReposted \(String(describing: post.userReposted))")
                        }
                        
                        post.viewsCount = item.views.count
                        print("post.viewsCount \(String(describing: post.viewsCount))")
                        
                        if let attachments = item.attachments {
                            for attachment in attachments {
                                print("<<<<<<<<<<<<<<<NEW ATTACHMENT>>>>>>>>>>>>>>>>>>>")
                                guard let newsPhoto = attachment.photo else { continue }
                                let photo = PhotoModel()
                                photo.albumId = newsPhoto.album_id
                                print("photo.albumId \(String(describing: photo.albumId))")
                                photo.date = Date(timeIntervalSince1970: newsPhoto.date)
                                print("photo.date \(String(describing: photo.date))")
                                photo.id = newsPhoto.id
                                print("photo.id \(String(describing: photo.id))")
                                photo.ownerId = newsPhoto.owner_id
                                print("photo.ownerId \(String(describing: photo.ownerId))")
                                photo.userId = newsPhoto.user_id
                                print("photo.userId \(String(describing: photo.userId))")
                                if newsPhoto.text.count > 0 {
                                    photo.text = newsPhoto.text
                                    print("photo.text \(String(describing: photo.text))")
                                }
                                
                                photo.cellSizeUrl = newsPhoto.getSize(size: .cellSize)?.url
                                print("photo.cellSizeUrl \(String(describing: photo.cellSizeUrl))")
                                photo.detailSizeUrl = newsPhoto.getSize(size: .detailSize)?.url
                                print("photo.detailSizeUrl \(String(describing: photo.detailSizeUrl))")
                                post.photos.append(photo)
                            }
                        }
                        
                        if item.source_id > 0, let profiles = getNewsFeedTypePostResponse?.response.profiles {
                            for profile in profiles {
                                if profile.id == item.source_id {
                                    let friend = Friend()
                                    friend.id = profile.id
                                    print("friend.id \(String(describing: friend.id))")
                                    friend.imageURL = profile.photo_100
                                    print("friend.imageURL \(String(describing: friend.imageURL))")
                                    friend.firstName = profile.first_name
                                    print("friend.firstName \(String(describing: friend.firstName))")
                                    friend.lastName = profile.last_name
                                    print("friend.lastName \(String(describing: friend.lastName))")
                                    post.userAuthor = friend
                                }
                            }
                        } else if item.source_id < 0, let groups = getNewsFeedTypePostResponse?.response.groups {
                            for group in groups {
                                if abs(item.source_id) == group.id {
                                    let groupModel = Public()
                                    groupModel.id = group.id
                                    print("groupModel.id \(String(describing: groupModel.id))")
                                    groupModel.imageURL = group.photo_100
                                    print("groupModel.imageURL \(String(describing: groupModel.imageURL))")
                                    groupModel.name = group.name
                                    print("groupModel.name \(String(describing: groupModel.name))")
                                    post.groupAuthor = groupModel
                                }
                            }
                        }
                    }
                }
            }
        })
        getNewsFeedTypePostDataTask?.resume()
    }
 
}
