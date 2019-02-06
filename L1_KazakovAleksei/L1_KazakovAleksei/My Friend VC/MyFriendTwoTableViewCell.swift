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
    var friendId: String?
    @IBOutlet weak var myFriendImageView: FriendPhoto?
    
    func setFriend(settingFriend: Friend) {
        let name = settingFriend.name ?? "NoName"
        let surname = settingFriend.surname ?? "NoSurname"
        self.friendNameLable?.text = name + " " + surname
        self.friendId? = settingFriend.id ?? "000000"
        self.myFriendImageView?.imageView?.image = UIImage(named: settingFriend.imageName ?? "No_Image")
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
