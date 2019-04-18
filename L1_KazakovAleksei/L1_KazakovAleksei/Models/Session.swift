//
//  Session.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

struct UserInfo {
    var userId: String = ""
}

struct SessionInfo {
    var token: String = ""
}

public class Session {
    
    static let instance = Session()
    private init () {}
    
    
    var userInfo = UserInfo()
    var sessionInfo = SessionInfo()
    
    

}
