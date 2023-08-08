//
//  TODOCollectionViewItem.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

struct Item: Hashable {

    let iconImage: UIImage
    let description: String
    let isChecked: Bool
    let priority: Priority
    let identifier = UUID()

    static let allItems = [
        Item(
            iconImage: UIImage(systemName: "headphones") ?? UIImage(),
            description: "Swift 공부하기", isChecked: false, priority: .high
        ),
        Item(
            iconImage: UIImage(systemName: "sun.min") ?? UIImage(),
            description: "물 한잔 마시기", isChecked: false, priority: .high
        ),
        Item(
            iconImage: UIImage(systemName: "keyboard") ?? UIImage(),
            description: "집 청소하기", isChecked: false, priority: .medium
        ),
        Item(
            iconImage: UIImage(systemName: "figure.walk") ?? UIImage(),
            description: "야곰한테 전화하기", isChecked: false, priority: .low
        )
    ]

}
