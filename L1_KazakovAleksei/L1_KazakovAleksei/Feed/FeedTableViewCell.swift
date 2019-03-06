//
//  FeedTableViewCell.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 11/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var newsLable: UILabel?

    @IBOutlet weak var wathCount: UILabel?
    
    weak var delegate: ShowDetailImage?
//    weak var frameDelegate: GetFrame?
    
    var cellIndexPath: IndexPath?
    var newsModel: NewsModel?
    
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
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var pageControl: UIPageControl?
    
    // далее в расчетах использовано много магических чисел. Небольшое пояснение: 26 - расстояние от нижнего края вью, в котором располагается скролл вью, до самого скролл вью (сделано для того, чтобы pageControl всегда был на белом пространстве). Все остальные числа - процентные части от 26 (13 = 50%, 6.5 = 25% итд).
    
    @IBAction func pageControlValueChanged () {
        self.scrollView?.setContentOffset(CGPoint(x: ((scrollView?.frame.width)! - 13) * CGFloat((self.pageControl?.currentPage)!), y: 0), animated: true)
    }
    
    func setupScrollView (imageNames: [String]) {
        for subview in (self.scrollView?.subviews)! {
            guard let feedImage = subview as? FeedImages else { continue }
            if feedImage.tag < imageNames.count {
                feedImage.setPostImage(imageName: imageNames[feedImage.tag])
            }
            
            
        }
        
        scrollView?.contentSize = CGSize(width: (((scrollView?.frame.width)! * CGFloat(imageNames.count)) - (CGFloat(imageNames.count) * 13)), height: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.newsModel?.scrollPosition = (self.scrollView?.contentOffset)!
//        print("scroll position in news model \(self.newsModel?.scrollPosition)")
//        print("scroll position self scrollView \(self.scrollView?.contentOffset)")
        let pageIndex = round(scrollView.contentOffset.x / ((self.scrollView?.frame.width)! - 13))
        self.pageControl?.currentPage = Int(pageIndex)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0...9 {
            let feedImage = FeedImages()
            feedImage.cell = self
            feedImage.setId(id: (i + 1))
            self.scrollView?.addSubview(feedImage)
            feedImage.tag = i
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in (self.scrollView?.subviews)! {
            guard let feedImage = subview as? FeedImages else { continue }
            if feedImage.tag == 0 {
                feedImage.frame = CGRect(x: (((scrollView?.frame.width)! - 13) * CGFloat(feedImage.tag) + 6.5), y: 0, width: ((scrollView?.frame.width)! - 26.0), height: ((scrollView?.frame.height)! - 26.0))
            } else {
                feedImage.frame = CGRect(x: (((scrollView?.frame.width)! - 13) * CGFloat(feedImage.tag) + 3.25), y: 0, width: ((scrollView?.frame.width)! - 26.0), height: ((scrollView?.frame.height)! - 26.0))
            }
            
        }
    }

    
    func setNews (settingNews news: NewsModel) {
        scrollView?.delegate = self
        newsLable?.text = news.newsText

        wathCount?.text = "300к"
        
        if news.stackImagesnames.count > 0 {
            setupScrollView(imageNames: news.stackImagesnames)
            scrollView?.setContentOffset(news.scrollPosition, animated: false)
            pageControl?.numberOfPages = news.stackImagesnames.count
            pageControl?.currentPage = 0
            bringSubviewToFront(pageControl!)
        }
        
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
        
        
        for subview in (self.scrollView?.subviews)! {
            guard let feedImage = subview as? FeedImages else { continue }
            feedImage.reuse()
        }
    }
    
    func didSelectedImage(image: FeedImages) {
        let imageId = image.id
        
        
        self.delegate?.getImageIndex(index: imageId ?? 1, indexPath: self.cellIndexPath!, image: image)
//        self.frameDelegate?.getFrame(image: image)
        
        
    }
    
    
    
}
