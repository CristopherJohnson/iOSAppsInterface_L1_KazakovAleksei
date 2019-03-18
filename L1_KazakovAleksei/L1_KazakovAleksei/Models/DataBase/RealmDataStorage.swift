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
    
    static func createForm (publicModel: Public) -> PublicsModelObject {
        let object = PublicsModelObject()
        object.name = publicModel.name!
        object.id = publicModel.id!
        object.imageURL = publicModel.imageURL!
        
        return object
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
}


class RealmDataStorage: IDataStorage {
    
    let dispathQueue = DispatchQueue(label: "RealmDataStorage")
    
    var realm: Realm?
    
    init() {
        self.dispathQueue.sync {
            do {
                self.realm = try Realm()
            } catch {
                print("RealmDataStorage init exception \(#file) \(#function) \(#line) \(error)")
            }
        }
    }
    
    
    
    func savePublic(publicModel: Public) {
        self.dispathQueue.sync {
            guard let realm = self.realm else {
                return
            }
            
            let object = PublicsModelObject.createForm(publicModel: publicModel)
            
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print("save publicModel exception \(#file) \(#function) \(#line) \(error)")
            }
            
        }
    }
    
    func saveFriend(friendModel: Friend) {
        self.dispathQueue.sync {
            guard let realm = self.realm else {
                return
            }
            
            let object = FriendsModelObject.createForm(friendModel: friendModel)
            
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print("save friendModel exception \(#file) \(#function) \(#line) \(error)")
            }
            
        }
    }
    
    
}
