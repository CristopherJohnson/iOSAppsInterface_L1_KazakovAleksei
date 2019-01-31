//
//  MyFriendsTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 01/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendNameLable: UILabel?
    @IBOutlet weak var friendImageView: UIImageView?
    var friendId: String?
    
    
    func setFriend(settingFriend: Friend) {
        self.friendNameLable?.text = settingFriend.name
        self.friendImageView?.image = UIImage(named: settingFriend.imageName ?? "No_Image")
        self.friendId? = settingFriend.id ?? "000000"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let image = friendImageView {
            image.layer.cornerRadius = image.frame.size.width / 2
            image.clipsToBounds = true
        }
        
    }

}
