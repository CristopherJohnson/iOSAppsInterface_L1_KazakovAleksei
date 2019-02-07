//
//  FriendsSectionIndex.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 07/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

@IBDesignable class FriendsSectionIndex: UIControl {
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    var allChars: [String] = []
    
    private func setupView() {
        for char in allChars {
            let button = UIButton(type: .system)
            button.setTitle(char, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    // MARK: - Init
    
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
