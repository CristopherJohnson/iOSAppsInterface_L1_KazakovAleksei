//
//  RealmDataStorage.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 18/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

import RealmSwift


class PublicsModelObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imageURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func createForm (publicModel: Public) -> PublicsModelObject {
        let object = PublicsModelObject()
        object.name = publicModel.name!
        object.id = publicModel.id!
        object.imageURL = publicModel.imageURL!
        
        return object
    }
    
    func create () -> Public {
        let publicModel = Public()
        publicModel.id = self.id
        publicModel.imageURL = self.imageURL
        publicModel.name = self.name
        
        return publicModel
    }
    
}

class FriendsModelObject: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imageURL: String = ""
    
    static func createForm (friendModel: Friend) -> FriendsModelObject {
        let object = FriendsModelObject()
        object.firstName = friendModel.firstName!
        object.lastName = friendModel.lastName!
        object.id = friendModel.id!
        object.imageURL = friendModel.imageURL!
        
        return object
    }
    
    func create () -> Friend {
        let friendModel = Friend()
        friendModel.id = self.id
        friendModel.imageURL = self.imageURL
        friendModel.firstName = self.firstName
        friendModel.lastName = self.lastName
        
        return friendModel
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    
}


class RealmDataStorage: IDataStorage {

    let dispathQueue = DispatchQueue(label: "RealmDataStorage")
    
    init() {
        self.dispathQueue.sync {
          
        }
    }
    
    
    
    func savePublic(publicModel: [Public], complition: @escaping ()->()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                return
            }
            
            for publ in publicModel {
                let object = PublicsModelObject.createForm(publicModel: publ)
                
                do {
                    try realm.write {
                        realm.add(object, update: true)
                    }
                } catch {
                    print("save publicModel exception \(#file) \(#function) \(#line) \(error)")
                }
            }
            
            DispatchQueue.main.async {
                complition()
            }
            
        }
    }
    
    func saveFriend(friendModel: [Friend], complition: @escaping ()->()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                return
            }
            
            for friend in friendModel {
                let object = FriendsModelObject.createForm(friendModel: friend)
                
                do {
                    try realm.write {
                        realm.add(object, update: true)
                    }
                } catch {
                    print("save friendModel exception \(#file) \(#function) \(#line) \(error)")
                }
            }
            
            DispatchQueue.main.async {
                complition()
            }
            
        }
    }
    
    
    func loadFriends (complition: @escaping ([Friend])->()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                complition([])
                return
            }
            
            var friendsArray: [Friend] = []
            
            let objects = realm.objects(FriendsModelObject.self)
            
            for object in objects {
                let friend = object.create()
                friendsArray.append(friend)
            }
            
            DispatchQueue.main.async {
                complition(friendsArray)
            }
        }
    }
    
    func loadPublics(complition: @escaping ([Public]) -> ()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                complition([])
                return
            }
            
            var publicsArray: [Public] = []
            
            let objects = realm.objects(PublicsModelObject.self)
            
            for object in objects {
                let publ = object.create()
                publicsArray.append(publ)
            }
            
            DispatchQueue.main.async {
                complition(publicsArray)
            }
        }
    }
    
    func delatePublics(publicsToDelete: [Public], complition: @escaping ()->()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                return
            }
            
            if publicsToDelete.count > 0 {
                for publ in publicsToDelete {
                    do {
                        try realm.write {
                            realm.delete(realm.object(ofType: PublicsModelObject.self, forPrimaryKey: publ.id)!)
                        }
                    } catch {
                        print("delete publics exception \(#file) \(#function) \(#line) \(error)")
                    }
                }
            }
            
            DispatchQueue.main.async {
                complition()
            }
        }
    }
    
    
    func delateFriends(friendsToDelete: [Friend], complition: @escaping () -> ()) {
        self.dispathQueue.sync {
            guard let realm = try? Realm() else {
                return
            }
            
            if friendsToDelete.count > 0 {
                for friend in friendsToDelete {
                    do {
                        try realm.write {
                            realm.delete(realm.object(ofType: FriendsModelObject.self, forPrimaryKey: friend.id)!)
                        }
                    } catch {
                        print("delete publics exception \(#file) \(#function) \(#line) \(error)")
                    }
                }
            }
            
            DispatchQueue.main.async {
                complition()
            }
        }
    }
    
}
