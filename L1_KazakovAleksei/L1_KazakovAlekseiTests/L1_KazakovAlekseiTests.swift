//
//  L1_KazakovAlekseiTests.swift
//  L1_KazakovAlekseiTests
//
//  Created by Алексей Казаков on 23/01/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import XCTest
@testable import L1_KazakovAleksei

class L1_KazakovAlekseiTests: XCTestCase {
    
    let dataString = """
{
    "response": {
        "count": 11,
        "items": [
            {
                "id": 18473476,
                "name": "Спортивные магазины \"СПОРТсеть\"",
                "screen_name": "sportset",
                "is_closed": 0,
                "type": "group",
                "is_admin": 1,
                "admin_level": 3,
                "is_member": 1,
                "is_advertiser": 1,
                "photo_50": "https://pp.userapi.com/c840122/v840122767/80f6/MHEICqmA7gQ.jpg?ava=1",
                "photo_100": "https://pp.userapi.com/c840122/v840122767/80f5/TexPR3vjDcE.jpg?ava=1",
                "photo_200": "https://pp.userapi.com/c840122/v840122767/80f4/ej58IdnTZks.jpg?ava=1"
            },
            {
                "id": 24651278,
                "name": "Manchester United | Манчестер Юнайтед",
                "screen_name": "mufans",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-11.userapi.com/c849128/v849128591/6fce9/bFpnCedyT64.jpg?ava=1",
                "photo_100": "https://sun9-30.userapi.com/c849128/v849128591/6fce8/saa4HYYkG9E.jpg?ava=1",
                "photo_200": "https://sun9-6.userapi.com/c849128/v849128591/6fce7/DJfG8TW3SDw.jpg?ava=1"
            },
            {
                "id": 23507102,
                "name": "Футбольные Трансферы",
                "screen_name": "transfers",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-17.userapi.com/c849124/v849124975/2ce5c/bAzSgBskXe0.jpg?ava=1",
                "photo_100": "https://sun9-33.userapi.com/c849124/v849124975/2ce5b/H6emD-tjkl0.jpg?ava=1",
                "photo_200": "https://sun9-28.userapi.com/c849124/v849124975/2ce5a/LQ5EOU4xhk4.jpg?ava=1"
            },
            {
                "id": 144863918,
                "name": "Черновик СС (СО)",
                "screen_name": "club144863918",
                "is_closed": 1,
                "type": "group",
                "is_admin": 1,
                "admin_level": 3,
                "is_member": 1,
                "is_advertiser": 1,
                "photo_50": "https://vk.com/images/community_50.png?ava=1",
                "photo_100": "https://vk.com/images/community_100.png?ava=1",
                "photo_200": "https://vk.com/images/community_200.png?ava=1"
            },
            {
                "id": 165032917,
                "name": "Сигналы от Bro",
                "screen_name": "signalsbro",
                "is_closed": 1,
                "type": "group",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-34.userapi.com/c831108/v831108385/d3878/-Gdw2ccBE3U.jpg?ava=1",
                "photo_100": "https://sun9-3.userapi.com/c831108/v831108385/d3877/bQueyJ_wB0M.jpg?ava=1",
                "photo_200": "https://sun9-2.userapi.com/c831108/v831108385/d3872/QexdbZ0LcfU.jpg?ava=1"
            },
            {
                "id": 25346844,
                "name": "5 интересных фактов",
                "screen_name": "v5inf",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-23.userapi.com/c834202/v834202483/17f521/tjQDvdNOjpg.jpg?ava=1",
                "photo_100": "https://sun9-14.userapi.com/c834202/v834202483/17f520/i_YdbpKrKTM.jpg?ava=1",
                "photo_200": "https://sun9-23.userapi.com/c834202/v834202483/17f51f/1KDJZ8xlXg0.jpg?ava=1"
            },
            {
                "id": 126459070,
                "name": "СпортСеть Петрозаводск",
                "screen_name": "club126459070",
                "is_closed": 0,
                "type": "group",
                "is_admin": 1,
                "admin_level": 3,
                "is_member": 1,
                "is_advertiser": 1,
                "photo_50": "https://pp.userapi.com/c844320/v844320249/114dc2/8Dya5j6EHxU.jpg?ava=1",
                "photo_100": "https://pp.userapi.com/c844320/v844320249/114dc1/P3uYJfuGOso.jpg?ava=1",
                "photo_200": "https://pp.userapi.com/c844320/v844320249/114dc0/RIlDbTw8mt4.jpg?ava=1"
            },
            {
                "id": 78835249,
                "name": "Спортивная медицина",
                "screen_name": "sportsmed",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-26.userapi.com/c633225/v633225709/44c72/o7hzjOXxQbo.jpg?ava=1",
                "photo_100": "https://sun9-4.userapi.com/c633225/v633225709/44c71/_1JvFAJ2apI.jpg?ava=1",
                "photo_200": "https://sun9-2.userapi.com/c633225/v633225709/44c70/UPqS1-Jvjqk.jpg?ava=1"
            },
            {
                "id": 138456906,
                "name": "Сигналы",
                "screen_name": "koltsignals",
                "is_closed": 1,
                "type": "group",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-6.userapi.com/c639327/v639327085/495a7/OPPW4GQuktA.jpg?ava=1",
                "photo_100": "https://sun9-33.userapi.com/c639327/v639327085/495a6/5YMyQsuoPeI.jpg?ava=1",
                "photo_200": "https://sun9-17.userapi.com/c639327/v639327085/495a5/57pXTGvI2Eo.jpg?ava=1"
            },
            {
                "id": 12637219,
                "name": "Европейский Футбол | Жеребьевка Лиги Чемпионов",
                "screen_name": "eurofoot",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://pp.userapi.com/c840224/v840224794/66df4/V3HF7hP66r8.jpg?ava=1",
                "photo_100": "https://pp.userapi.com/c840224/v840224794/66df3/2X83zEgJptY.jpg?ava=1",
                "photo_200": "https://pp.userapi.com/c840224/v840224794/66df1/NFvJf_v4dBs.jpg?ava=1"
            },
            {
                "id": 46440216,
                "name": "HFM Show",
                "screen_name": "hfmshow",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 1,
                "is_advertiser": 0,
                "photo_50": "https://sun9-24.userapi.com/c845121/v845121025/1a9f1a/xauI4slHvm4.jpg?ava=1",
                "photo_100": "https://sun9-13.userapi.com/c845121/v845121025/1a9f19/TUO1syh95fM.jpg?ava=1",
                "photo_200": "https://sun9-21.userapi.com/c845121/v845121025/1a9f18/l_P5xtVPUN4.jpg?ava=1"
            }
        ]
    }
}
"""
    
    var requestData = RequestData()
    let configuration = URLSessionConfiguration.default
    var data: Data?

    func testExample() {
        
        let session = URLSession(configuration: self.configuration)
        
        
        let getGroupsListDataTask = session.dataTask(with: self.requestData.generateRequestToGetGroups()!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                self.data = responseData
            }
        }
        getGroupsListDataTask.resume()
        
        let getGroupsResponse: GetGroups? = Parser.parseGroups(data: data)
        
        print("List: ")
        if let items = getGroupsResponse?.response.items {
            for item in items {
                print("   Item:")
                print("     Item id: \(item.id)")
                print("     Item name: \(item.name)")
                print("     Item photo_50: \(item.photo_50)")
                print("     Item photo_100: \(item.photo_100)")
                print("     Item photo_200: \(item.photo_200)")
            }
        }
        
        XCTAssertNotNil(getGroupsResponse)

    }


}
