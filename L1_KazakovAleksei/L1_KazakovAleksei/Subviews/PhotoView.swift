//
//  PhotoView.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 07/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    
    private let photosPageControlHeigh: CGFloat = 39
    private weak var pageControl: UIPageControl?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: - Setup
    
    public func setup (photos: [PhotoModel]) {
        if photos.count == 1, let photo = photos.first, let url = photo.cellSizeUrl {
            let imageView = UIImageView()
            ImageService.shared.get(urlString: url) { (image: UIImage?) in
                if let loadedImage = image {
                    imageView.image = loadedImage
                } else {
                    print("NewsFeed post Image loading error")
                }
            }
            imageView.frame = self.bounds
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            self.addSubview(imageView)
        } else if photos.count > 1 {
            let scrollView = UIScrollView()
            scrollView.frame = CGRect(x: 12,
                                      y: 0,
                                      width: self.bounds.size.width - 20,
                                      height: self.bounds.size.height - self.photosPageControlHeigh)
            scrollView.isPagingEnabled = true
            scrollView.clipsToBounds = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = self
            
            let pageControl = UIPageControl()
            pageControl.numberOfPages = photos.count
            pageControl.currentPage = 0
            
            let color = UIColor(red: 0.32, green: 0.51, blue: 0.72, alpha: 1)
            pageControl.tintColor = color
            pageControl.pageIndicatorTintColor = color.withAlphaComponent(0.32)
            pageControl.currentPageIndicatorTintColor = color
            self.addSubview(pageControl)
            pageControl.center = CGPoint(x: center.x, y: self.bounds.size.height - (self.photosPageControlHeigh / 2))
            self.pageControl = pageControl
            
            let photoWidth: CGFloat = scrollView.bounds.size.width
            
            for (index, photo) in photos.enumerated() {
                let imageView = UIImageView()
                imageView.frame = CGRect(x: CGFloat(index) * photoWidth, y: 0, width: photoWidth - 4, height: scrollView.bounds.size.height)
                if let url = photo.cellSizeUrl {
                    ImageService.shared.get(urlString: url) { (image: UIImage?) in
                        if let loadedImage = image {
                            imageView.image = loadedImage
                        } else {
                            print("NewsFeed post Image in scroll view loading error")
                        }
                    }
                }
                imageView.clipsToBounds = true
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                scrollView.addSubview(imageView)
            }
            scrollView.contentSize = CGSize(width: photoWidth * CGFloat(photos.count), height: 0)
            self.addSubview(scrollView)
        }
    }
    
    //MARK: - reuse
    
    public func reuse () {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

extension PhotoView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl?.currentPage = Int(pageNumber)
    }
}
