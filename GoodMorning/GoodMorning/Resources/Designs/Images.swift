//
//  Images.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/18.
//

enum Image {

    case luck
    case trash
    case check
    case question

    var systemName: String {
        switch self {
        case .luck:
            return "bubbles.and.sparkles.fill"
        case .trash:
            return "trash"
        case .check:
            return "checkmark"
        case .question:
            return "questionmark.circle.fill"
        }
    }

}
