//
//  CALayer+.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/17.
//

import UIKit

extension CALayer {

    func configureBorder(
        cornerRadius: CGFloat = 10,
        borderWidth: CGFloat = 1,
        borderColor: CGColor? = UIColor.gray.cgColor
    ) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }

}
