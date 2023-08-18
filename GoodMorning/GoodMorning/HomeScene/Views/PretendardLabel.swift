//
//  PretendardLabel.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import UIKit

final class PretendardLabel: UILabel {

    init(
        text: String,
        color: UIColor = .black,
        alignment: NSTextAlignment = .center,
        size: CGFloat,
        weight: UIFont.Weight
    ) {
        super.init(frame: .zero)

        self.text = text
        self.font = .pretendard(size: size, weight: weight)
        self.adjustsFontForContentSizeCategory = true
        self.textColor = color
        self.textAlignment = alignment
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
