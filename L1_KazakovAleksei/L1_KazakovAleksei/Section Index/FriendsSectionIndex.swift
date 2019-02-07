//
//  FriendsSectionIndex.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 07/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

enum Char: Int {
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    static let allChars: [Char] = [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
    var title: String {
        switch self {
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        case .d: return "D"
        case .e: return "E"
        case .f: return "F"
        case .g: return "G"
        case .h: return "H"
        case .i: return "I"
        case .j: return "J"
        case .k: return "K"
        case .l: return "L"
        case .m: return "M"
        case .n: return "N"
        case .o: return "O"
        case .p: return "P"
        case .q: return "Q"
        case .r: return "R"
        case .s: return "S"
        case .t: return "T"
        case .u: return "U"
        case .v: return "V"
        case .w: return "W"
        case .x: return "X"
        case .y: return "Y"
        case .z: return "Z"
        }
    }
}

@IBDesignable class FriendsSectionIndex: UIControl {
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    var allExistingChars: [String] = []
//    var allCharsTwo: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var selectedChar: Char? = nil {
        didSet {
            self.updateSelectedChar()
            self.sendActions(for: .valueChanged)
        }
    }
    
    
    
//    func getChars(chars: [String]){
//        self.allChars = chars
//    }
    
    private func setupView() {
        for char in Char.allChars {
            let button = UIButton(type: .system)
            button.setTitle(char.title, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.addTarget(self, action: #selector(selectChar(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func updateSelectedChar() {
        for (index, button) in self.buttons.enumerated() {
            guard let char = Char(rawValue: index) else { continue }
            button.isSelected = char == self.selectedChar
        }
    }
    
    @objc private func selectChar(_ sender: UIButton) {
        guard let index = self.buttons.index(of: sender) else { return }
        guard let char = Char(rawValue: index) else { return }
        self.selectedChar = char
    }
    
    @objc private func panAction(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .changed:
            let currentPoint = pan.location(in: self)
//            let selectedButton = hitTest(currentPoint, with: nil)
//            if selectedButton != nil {
//                let button: UIButton = selectedButton
//            }
            for button in buttons {
                if button.frame.contains(currentPoint) {
                    let index = self.buttons.index(of: button)
                    let char = Char(rawValue: index!)
                    self.selectedChar = char
                }
            }
            
//        case .began:
//            guard let index = self.buttons.index(of: sender) else { return }
//            guard let char = Char(rawValue: index) else { return }
//            if char != self.selectedChar {
//                self.selectedChar = char
//            }
        default:
            return
        }
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
    override func awakeFromNib() {
        super.awakeFromNib()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(pan:)))
        self.addGestureRecognizer(panGesture)
    }

    
    //    TODO: - delite all buttons, then create them again
    func reload () {
        for button in buttons {
            if !allExistingChars.contains(button.currentTitle!) {
                button.removeFromSuperview()
            }
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
