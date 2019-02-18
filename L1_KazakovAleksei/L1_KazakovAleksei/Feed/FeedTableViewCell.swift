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
    
    @IBOutlet weak var stackImage1: FeedImages?
    
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView?.image = nil
        self.newsLable?.text = nil
        self.wathCount?.text = nil
    }
    
}
