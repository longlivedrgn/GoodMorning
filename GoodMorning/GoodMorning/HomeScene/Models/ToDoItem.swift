//
//  ToDoItem.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

struct ToDoItem: Hashable {

    var iconImage: String?
    var title: String
    var description: String?
    var isChecked: Bool
    var priority: Priority
    let identifier: UUID = UUID()

    static let allItems = [
        ToDoItem(
            iconImage: "ㅎ", 
            title: "zz",
            description: "Swift 공부하기", isChecked: false, priority: .high
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "zz",
            description: "물 한잔 마시기", isChecked: false, priority: .high
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "zz",
            description: "집 청소하기", isChecked: false, priority: .medium
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "zz",
            description: "야곰한테 전화하기", isChecked: false, priority: .low
        )
    ]

}
