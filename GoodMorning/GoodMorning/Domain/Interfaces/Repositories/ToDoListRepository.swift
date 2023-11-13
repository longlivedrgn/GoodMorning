//
//  ToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

import Foundation.NSUUID

protocol ToDoListRepository {

    func fetchToDoList() -> [ToDoItem]
    func addToDoItem(item: ToDoItem) async throws
    func deleteToDoItem(_ id: UUID) throws
    func updateToDoItem(
        _ id: UUID,
        title: String?,
        isChecked: Bool,
        routine: String?,
        icon: String?,
        priority: Priority
    ) throws

}
