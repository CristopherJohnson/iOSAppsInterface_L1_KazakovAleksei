//
//  FeedTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 11/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsLable: UILabel?
    @IBOutlet weak var newsImageView: UIImageView?
    @IBOutlet weak var wathCount: UILabel?
    
    
    
    func setNews (settingNews news: NewsModel) {
        newsLable?.text = news.newsText
        newsImageView?.image = UIImage(named: news.newsImageName ?? "No_Image")
        wathCount?.text = "300к"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView?.image = nil
        self.newsLable?.text = nil
        self.wathCount?.text = nil
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
