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
        }
    }
    
    //MARK: - reuse
    
    public func reuse () {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
