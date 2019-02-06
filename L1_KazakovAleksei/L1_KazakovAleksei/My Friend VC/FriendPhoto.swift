//
//  FriendPhoto.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

@IBDesignable class FriendPhoto: UIView {
    
    weak var imageView: UIImageView?
    
    @IBInspectable var shadowOffset: CGSize = CGSize() {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.imageView?.frame = self.bounds
        self.imageView?.layer.cornerRadius = self.frame.size.width / 2
        self.imageView?.layer.masksToBounds = true
    

    }
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviews()
        
    }
    
    // MARK: - subviews
    
    private func addSubviews() {
        if self.imageView == nil {
            let imageView = UIImageView(image: UIImage(named: "No_Image"))
            self.addSubview(imageView)
            self.imageView = imageView
        }
    }
  
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
