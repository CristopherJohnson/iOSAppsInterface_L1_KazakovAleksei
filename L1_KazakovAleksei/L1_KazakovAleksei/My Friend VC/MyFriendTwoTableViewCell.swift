//
//  MyFriendTwoTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyFriendTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var friendNameLable: UILabel?
    var friendFakeId: String?
    var friendsId: Int?
    @IBOutlet weak var myFriendImageView: FriendPhoto?
    
    func setFriend(settingFriend: Friend) {
//        let name = settingFriend.fakeName ?? "NoName"
//        let surname = settingFriend.fakeSurname ?? "NoSurname"
        let name = settingFriend.firstName ?? "NoName"
        let surname = settingFriend.lastName ?? "NoSurname"
        self.friendNameLable?.text = name + " " + surname
        self.friendsId? = settingFriend.id!
        self.friendFakeId? = settingFriend.fakeId ?? "000000"
//        self.myFriendImageView?.imageView?.image = UIImage(named: settingFriend.imageName ?? "No_Image")
        self.myFriendImageView?.imageView?.load(url: URL(string: settingFriend.imageURL!)!)
    }
    

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        if let image = friendImageView {
//            image.layer.cornerRadius = image.frame.size.width / 2
//            image.clipsToBounds = true
//        }
//        
//    }

}
