//
//  Priority.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

enum Priority {

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

}
