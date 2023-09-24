//
//  ToDoListRepository.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import Foundation
// HomeScene에서 CoreData를 통해서 ToDoList가져오기
// 현재 ToDoList를 CoreData에 저장하기
protocol ToDoListRepository {
    func fetchToDoList()
    func saveToDoList()
}
