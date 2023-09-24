//
//  ToDoListEditRepository.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import Foundation

// ToDoList를 저장하기
// ToDoList를 하나 없애기
protocol ToDoListEditRepository {
    func saveToDoListContent()
    func deleteToDoListContent()
}
