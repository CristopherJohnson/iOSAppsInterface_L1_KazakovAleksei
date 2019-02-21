//
//  LoaderPoints.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 18/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

enum LoaderAnimationStep {
    case step1
    case step2
    case step3
    case stepEnd
}

class LoaderPoints: UIView {
    
    private weak var pointImageView1: UIImageView?
    private weak var pointImageView2: UIImageView?
    private weak var pointImageView3: UIImageView?
    private var stackView: UIStackView?
    
    var animationStep: LoaderAnimationStep = .step1 {
        didSet {
            self.updateStep()
        }
    }
    
    let animationDuration: TimeInterval = 0.5
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    //MARK: - Layout
    
    private func setupView () {
        let pointImage = UIImageView(image: UIImage(named: "loadingPoint"))
        pointImage.alpha = 0.5
        pointImage.contentMode = UIView.ContentMode.scaleAspectFit
        self.pointImageView1 = pointImage
        let pointImage2 = UIImageView(image: UIImage(named: "loadingPoint"))
        pointImage2.alpha = 0.5
        pointImage2.contentMode = UIView.ContentMode.scaleAspectFit
        self.pointImageView2 = pointImage2
        let pointImage3 = UIImageView(image: UIImage(named: "loadingPoint"))
        pointImage3.alpha = 0.5
        pointImage3.contentMode = UIView.ContentMode.scaleAspectFit
        self.pointImageView3 = pointImage3
        
        self.stackView = UIStackView(arrangedSubviews: [self.pointImageView1!, self.pointImageView2!, self.pointImageView3!])
        self.addSubview(stackView!)
        
        stackView?.spacing = 1
        stackView?.axis = .horizontal
        stackView?.alignment = .fill
        stackView?.distribution = .fillEqually
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.stackView?.frame = bounds
    }
    
    //MARK: - Animation
    
    func startAnimation () {
        self.updateStep()
    }
    
    func updateStep() {
        switch self.animationStep {
        case .step1:
            self.animateStep1()
        case .step2:
            self.animateStep2()
        case .step3:
            self.animateStep3()
        case .stepEnd:
            self.animateStepEnd()
        }
    }
    
    func animateStep1 () {
        UIView.animate(withDuration: self.animationDuration,
                       animations: {
                        self.pointImageView1?.alpha = 1
        }) { (finished: Bool) in
            self.animationStep = .step2
        }
    }
    
    func animateStep2 () {
        UIView.animate(withDuration: self.animationDuration,
                       animations: {
                        self.pointImageView2?.alpha = 1
        }) { (finished: Bool) in
            self.animationStep = .step3
        }
    }
    
    func animateStep3 () {
        UIView.animate(withDuration: self.animationDuration,
                       animations: {
                        self.pointImageView3?.alpha = 1
        }) { (finished: Bool) in
            self.animationStep = .stepEnd
        }
    }
    
    func animateStepEnd () {
        UIView.animate(withDuration: self.animationDuration,
                       animations: {
                        self.pointImageView1?.alpha = 0.5
                        self.pointImageView2?.alpha = 0.5
                        self.pointImageView3?.alpha = 0.5
        }) { (finished: Bool) in
            self.animationStep = .step1
        }
    }

}
