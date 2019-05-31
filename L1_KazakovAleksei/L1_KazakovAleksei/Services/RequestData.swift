//
//  RequestData.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 06/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation


class RequestData {
    var scheme = "https"
    var host = "api.vk.com"
    var session = Session.instance
    var body: Data?
    var method: String = "GET"
    var apiVersion = "5.92"
    
    func generateRequestToGetFriensList () -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "nickname,photo_100"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
        
    }
    
    func generateRequestToGetPhotos () -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "skip_hidden", value: "0"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
    }
    
    func generateRequestToGetGroups () -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
    }
    
    func generateReguestToSearchGroups () -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "Manchester"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
    }
    
    func generateRequestToGetNewsFeed (startFrom: String?) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "return_banned", value: "0"),
            URLQueryItem(name: "max_photos", value: "10"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        if let from = startFrom {
            urlComponents.queryItems?.append(URLQueryItem(name: "start_from", value: from))
        }
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
    }
    
    func generateRequestToGetComments (ownerID: String, postID: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = "/method/wall.getComments"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "post_id", value: postID),
            URLQueryItem(name: "need_likes", value: "1"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "sort", value: "desc"),
            URLQueryItem(name: "preview_length", value: "0"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "thread_items_count", value: "3"),
            URLQueryItem(name: "access_token", value: self.session.sessionInfo.token),
            URLQueryItem(name: "v", value: self.apiVersion)
        ]
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            request.httpMethod = self.method
            request.httpBody = self.body
            return request
            
        }
        return nil
    }
    
}
