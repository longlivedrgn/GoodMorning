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

}
