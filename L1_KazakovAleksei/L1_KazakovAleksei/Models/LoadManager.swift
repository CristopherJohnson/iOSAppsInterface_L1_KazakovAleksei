//
//  LoadManager.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 25/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

public let groupsRealmDataWasChanged = "groupsRealmDataWasChanged"
public let friendsRealmDataWasChanged = "friendsRealmDataWasChanged"

class LoadManager {
    static let shared = LoadManager()
    private init () {}
    
    public func refreshPublics () {
        APIManager.shared.getPublics { (publicsArray: [Public]?) in
            if let publics = publicsArray {
                self.comparePublics(loadedPublics: publics)
            }
        }
    }
    
    
    private func comparePublics (loadedPublics: [Public]) {
        DataStorage.shared.loadPublics { (oldPublics: [Public]) in
            var publicsToDelete: [Public] = []
            for publ in oldPublics {
                let contains = loadedPublics.contains(where: { (newPubl) -> Bool in
                    if newPubl.id == publ.id {
                        return true
                    } else {
                        return false
                    }
                })
                if contains == false {
                    publicsToDelete.append(publ)
                }
            }
            DataStorage.shared.delatePublics(publicsToDelete: publicsToDelete, complition: {
                DataStorage.shared.savePublic(publicModel: loadedPublics, complition: {
                    self.postPublicsUpdateNitifications()
                })
            })
            
        }
    }
    
    private func postPublicsUpdateNitifications () {
        let nitificationName = Notification.Name(groupsRealmDataWasChanged)
        let notification = Notification(name: nitificationName)
        NotificationCenter.default.post(notification)
    }
    
    
    public func refreshfriends () {
        APIManager.shared.getFriends { (friendsArray: [Friend]?) in
            if let friends = friendsArray {
                self.compareFriends(loadedFriends: friends)
            }
        }
    }
    
    private func compareFriends (loadedFriends: [Friend]) {
        DataStorage.shared.loadFriends { (oldFriends:[Friend] ) in
            var friendsToDelete: [Friend] = []
            for friend in oldFriends {
                let contains = loadedFriends.contains(where: { (newFriend) -> Bool in
                    if newFriend.id == friend.id {
                        return true
                    } else {
                        return false
                    }
                })
                if contains == false {
                    friendsToDelete.append(friend)
                }
            }
            DataStorage.shared.delateFriends(friendsToDelete: friendsToDelete, complition: {
                DataStorage.shared.saveFriend(friendModel: loadedFriends, complition: {
                    self.postFriendsUpdateNotification()
                })
            })
        }
    }
    
    private func postFriendsUpdateNotification () {
        let nitificationName = Notification.Name(friendsRealmDataWasChanged)
        let notification = Notification(name: nitificationName)
        NotificationCenter.default.post(notification)
    }
    
    
}
