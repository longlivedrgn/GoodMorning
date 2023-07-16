//
//  UIFont+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import UIKit

extension UIFont {

    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"

        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Blod"
        case .heavy:
            weightString = "ExtraBold"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ??
            .systemFont(ofSize: fontSize, weight: weight)
    }

}
