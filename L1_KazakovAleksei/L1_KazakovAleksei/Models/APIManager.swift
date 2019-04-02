//
//  APIManager.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation


protocol APIProtocol: class {
    func getFriends (complition: @escaping (GetFriends?)->())
    func getPublics (complition: @escaping ([Public]?)->())
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
    
    
    func getFriends(complition: @escaping (GetFriends?) -> ()) {
        let getFriendsListDataTask = urlSession?.dataTask(with: self.requestData.generateRequestToGetFriensList()!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                let getFriendsResponse: GetFriends? = Parser.parseFriends(data: responseData)
                complition(getFriendsResponse)
                
                print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
                
            }
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
    
 
}
