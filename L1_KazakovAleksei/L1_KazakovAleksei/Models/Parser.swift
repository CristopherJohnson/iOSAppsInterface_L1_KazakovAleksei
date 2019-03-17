//
//  Parser.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 15/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation


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




