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
        stackImageView1?.setPostImage(imageName: "Avatar1")
        stackImageView2?.setPostImage(imageName: "Avatar2")
        stackImageView3?.setPostImage(imageName: "Avatar3")
        stackImageView4?.setPostImage(imageName: "Avatar4")
        stackImageView5?.setPostImage(imageName: "Avatar5")
        stackImageView6?.setPostImage(imageName: "Public1")
        stackImageView7?.setPostImage(imageName: "Public2")
        stackImageView8?.setPostImage(imageName: "Public3")
        stackImageView9?.setPostImage(imageName: "Public4")
        stackImageView10?.setPostImage(imageName: "Public5")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView?.image = nil
        self.newsLable?.text = nil
        self.wathCount?.text = nil
    }
    
}
