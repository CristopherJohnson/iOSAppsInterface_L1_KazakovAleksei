//
//  StringExtension.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 26/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func heightOfString(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
