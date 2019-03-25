//
//  MyPublicsTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 01/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyPublicsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var publicNameLable: UILabel?
    @IBOutlet weak var publicImageView: UIImageView?
    var publicId: String?
    
    
    func setPublic(settingPublic: Public) {
        self.publicNameLable?.text = settingPublic.name
        self.publicImageView?.load(url: URL(string: settingPublic.imageURL!)!)

//        self.publicImageView?.image = UIImage(named: settingPublic.imageName ?? "No_Image")
        self.publicId? = settingPublic.fakeId ?? "000000"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let image = publicImageView {
            image.layer.cornerRadius = image.frame.size.width / 2
            image.clipsToBounds = true
        }
        
    }

}


