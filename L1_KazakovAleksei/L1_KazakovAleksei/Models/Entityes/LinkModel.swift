//
//  LinkModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 29/06/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation

class LinkModel: NSObject {
    var link: String
    var range: NSRange
    
    init(link: String, range: NSRange) {
        self.link = link
        self.range = range
    }
}
