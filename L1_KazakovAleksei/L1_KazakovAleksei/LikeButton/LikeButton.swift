//
//  LikeButton.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

@IBDesignable class LikeButton: UIControl {

    private var button = UIButton(type: UIButton.ButtonType.custom) as UIButton
    private func setupView() {
        button.setImage(UIImage(named: "dislike"), for: .normal)
        button.setTitle("11", for: .normal)
        self.addSubview(button)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
