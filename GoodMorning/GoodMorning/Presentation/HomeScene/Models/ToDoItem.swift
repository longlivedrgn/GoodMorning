//
//  ToDoItem.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

struct ToDoItem: Hashable {

    var iconImage: String?
    var title: String?
    var description: String?
    var isChecked: Bool
    var priority: Priority
    let identifier: UUID = UUID()

    static let allItems = [
        ToDoItem(
            iconImage: "ㅎ", 
            title: "Swift 공부하기",
            description: "Swift 공부하기111", isChecked: false, priority: .high
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "물 한잔 마시기",
            description: "물 한잔 마시기22222", isChecked: false, priority: .high
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "집 청소하기",
            description: "집 청소하기3333", isChecked: false, priority: .medium
        ),
        ToDoItem(
            iconImage: "ㅎ",
            title: "야곰한테 전화하기",
            description: "야곰한테 전화하기444", isChecked: false, priority: .low
        )
    ]

}
