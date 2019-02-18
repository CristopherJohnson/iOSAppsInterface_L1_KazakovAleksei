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
    
    @IBOutlet weak var stackImageView1: FeedImages?
    @IBOutlet weak var stackImageView2: FeedImages?
    @IBOutlet weak var stackImageView3: FeedImages?
    @IBOutlet weak var stackImageView4: FeedImages?
    @IBOutlet weak var stackImageView5: FeedImages?
    @IBOutlet weak var stackImageView6: FeedImages?
    @IBOutlet weak var stackImageView7: FeedImages?
    @IBOutlet weak var stackImageView8: FeedImages?
    @IBOutlet weak var stackImageView9: FeedImages?
    @IBOutlet weak var stackImageView10: FeedImages?
    
    @IBOutlet weak var newsimageViewButton: UIButton?
    
    private let scaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    @IBAction func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.newsImageView?.transform = self.scaleTransform
        }
    }
    
    @IBAction func touchUpInside() {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
            self.newsImageView?.transform = CGAffineTransform.identity
        }) { (finished: Bool) in
            
        }
        
    }
    
    @IBAction func touchUpOutside() {
        UIView.animate(withDuration: 0.2) {
            self.newsImageView?.transform = CGAffineTransform.identity
        }
        
    }
    
    @IBAction func touchCancel (){
        UIView.animate(withDuration: 0.2) {
            self.newsImageView?.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func setNews (settingNews news: NewsModel) {
        newsLable?.text = news.newsText
        newsImageView?.image = UIImage(named: news.newsImageName ?? "No_Image")
        wathCount?.text = "300к"
        stackImageView1?.setPostImage(imageName: news.stackImagesnames[0])
        stackImageView2?.setPostImage(imageName: news.stackImagesnames[1])
        stackImageView3?.setPostImage(imageName: news.stackImagesnames[2])
        stackImageView4?.setPostImage(imageName: news.stackImagesnames[3])
        stackImageView5?.setPostImage(imageName: news.stackImagesnames[4])
        stackImageView6?.setPostImage(imageName: news.stackImagesnames[5])
        stackImageView7?.setPostImage(imageName: news.stackImagesnames[6])
        stackImageView8?.setPostImage(imageName: news.stackImagesnames[7])
        stackImageView9?.setPostImage(imageName: news.stackImagesnames[8])
        stackImageView10?.setPostImage(imageName: news.stackImagesnames[9])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView?.image = nil
        self.newsLable?.text = nil
        self.wathCount?.text = nil
        stackImageView1?.setPostImage(imageName: nil)
        stackImageView2?.setPostImage(imageName: nil)
        stackImageView3?.setPostImage(imageName: nil)
        stackImageView4?.setPostImage(imageName: nil)
        stackImageView5?.setPostImage(imageName: nil)
        stackImageView6?.setPostImage(imageName: nil)
        stackImageView7?.setPostImage(imageName: nil)
        stackImageView8?.setPostImage(imageName: nil)
        stackImageView9?.setPostImage(imageName: nil)
        stackImageView10?.setPostImage(imageName: nil)
    }
    
}
