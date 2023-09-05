//
//  UIImage+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/18.
//

import UIKit

extension UIImage {

    static func SFSymbol(_ type: Image) -> UIImage? {
        return UIImage(systemName: type.systemName)
    }

    func withAlpha(_ alpha: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(at: .zero, blendMode: .normal, alpha: alpha)
        }
    }

}
