//
//  UIColor+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import UIKit

extension UIColor {

    class func design(_ color: Palette) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
    
}
