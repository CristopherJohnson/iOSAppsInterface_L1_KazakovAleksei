//
//  LoadManager.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation


class LoadManager {
    static let shared = LoadManager()
    
    
    func loadFriends (complition: @escaping ([Friend])->()) {
        var friendsArray: [Friend] = []
        DataStorage.shared.loadFriends { (friends: [Friend]) in
            friendsArray = friends
            if friendsArray.count > 0 {
                
                OperationQueue.main.addOperation {
                    complition(friendsArray)
                }
                print("loading from Realm")
                
            } else if friendsArray.count == 0 {
                APIManager.shared.getFriends { (friends: GetFriends?) in
                    if let items = friends?.response.items {
                        for item in items {
                            let friend = Friend()
                            friend.id = item.id
                            friend.firstName = item.first_name
                            friend.lastName = item.last_name
                            friend.imageURL = item.photo_100
                            friendsArray.append(friend)
                        }
                        OperationQueue.main.addOperation {
                            complition(friendsArray)
                        }
                        DataStorage.shared.saveFriend(friendModel: friendsArray)
                    }
                }
                
            }
        }
    }
    
    
    func loadPublics (complition: @escaping ([Public])->()){
        var publicArray: [Public] = []
        
        DataStorage.shared.loadPublics { (publics: [Public]) in
            publicArray = publics
            
            if publicArray.count > 0 {
                OperationQueue.main.addOperation {
                    complition(publicArray)
                }
                print("loading from Realm")
            } else if publicArray.count == 0 {
                APIManager.shared.getPublics(complition: { (groups: GetGroups?) in
                    if let items = groups?.response.items {
                        for item in items {
                            let publ = Public()
                            publ.id = item.id
                            publ.name = item.name
                            publ.imageURL = item.photo_200
                            publicArray.append(publ)
                        }
                        OperationQueue.main.addOperation {
                            complition(publicArray)
                        }
                        DataStorage.shared.savePublic(publicModel: publicArray)
                    }
                })
            }
        }
    }
    
}
