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
    
    weak var delegate: ShowDetailImage?
    
    var cellIndexPath: IndexPath?
    
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
        
        stackImageView1?.setId(id: 1)
        stackImageView2?.setId(id: 2)
        stackImageView3?.setId(id: 3)
        stackImageView4?.setId(id: 4)
        stackImageView5?.setId(id: 5)
        stackImageView6?.setId(id: 6)
        stackImageView7?.setId(id: 7)
        stackImageView8?.setId(id: 8)
        stackImageView9?.setId(id: 9)
        stackImageView10?.setId(id: 10)
        
        stackImageView1?.cell = self
        stackImageView2?.cell = self
        stackImageView3?.cell = self
        stackImageView4?.cell = self
        stackImageView5?.cell = self
        stackImageView6?.cell = self
        stackImageView7?.cell = self
        stackImageView8?.cell = self
        stackImageView9?.cell = self
        stackImageView10?.cell = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView?.image = nil
        self.newsLable?.text = nil
        self.wathCount?.text = nil
        stackImageView1?.reuse()
        stackImageView2?.reuse()
        stackImageView3?.reuse()
        stackImageView4?.reuse()
        stackImageView5?.reuse()
        stackImageView6?.reuse()
        stackImageView7?.reuse()
        stackImageView8?.reuse()
        stackImageView9?.reuse()
        stackImageView10?.reuse()
    }
    
    func didSelectedImage(image: FeedImages) {
        let imageId = image.id
        
        
        self.delegate?.getImageIndex(index: imageId ?? 1, indexPath: self.cellIndexPath!)
        
        
        print("id: \(imageId)")
    }
    
}
