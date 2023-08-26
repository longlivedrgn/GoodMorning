//
//  Priority.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

enum Priority: Int, CaseIterable {

    case high
    case medium
    case low

    var color: UIColor {
         switch self {
         case .high:
             return UIColor.red
         case .medium:
             return UIColor.orange
         case .low:
             return UIColor.blue
         }
     }

    var image: UIImage? {
        switch self {
        case .high:
            return UIImage(named: "Priority.high")
        case .medium:
            return UIImage(named: "Priority.medium")
        case .low:
            return UIImage(named: "Priority.low")
        }
    }

}
