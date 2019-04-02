//
//  DataStorage.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 18/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

protocol IDataStorage {
    func savePublic(publicModel: [Public])
    func saveFriend(friendModel: [Friend])
    func loadFriends (complition: @escaping ([Friend])->())
    func loadPublics (complition: @escaping ([Public])->())
    func delatePublics(publicsToDelete:[Public])
}

class DataStorage {
    private init () {}
    
    static let shared: IDataStorage = RealmDataStorage()
}

