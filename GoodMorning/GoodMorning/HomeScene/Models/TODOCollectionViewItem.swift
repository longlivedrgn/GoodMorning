//
//  TODOCollectionViewItem.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

struct TODOItem: Hashable {

    let iconImage: String?
    let description: String
    let isChecked: Bool
    let priority: Priority
    let identifier: UUID = UUID()

    static let allItems = [
        TODOItem(
            iconImage: "ㅎ",
            description: "Swift 공부하기", isChecked: false, priority: .high
        ),
        TODOItem(
            iconImage: "ㅎ",
            description: "물 한잔 마시기", isChecked: false, priority: .high
        ),
        TODOItem(
            iconImage: "ㅎ",
            description: "집 청소하기", isChecked: false, priority: .medium
        ),
        TODOItem(
            iconImage: "ㅎ",
            description: "야곰한테 전화하기", isChecked: false, priority: .low
        )
    ]

}
