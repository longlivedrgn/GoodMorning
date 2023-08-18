//
//  Images.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/18.
//

enum Image {

    case luck

    var systemName: String {
        switch self {
        case .luck:
            return "bubbles.and.sparkles.fill"
        }
    }

}
