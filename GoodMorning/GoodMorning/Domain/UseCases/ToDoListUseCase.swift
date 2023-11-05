//
//  ToDoListUseCase.swift
//  GoodMorning
//
//  Created by Sunny on 11/3/23.
//

import Foundation.NSUUID

final class ToDoListUseCase {

    private let todoListRepository: ToDoListRepository

    init(todoListRepository: ToDoListRepository) {
        self.todoListRepository = todoListRepository
    }

    func fetchToDoList() -> [ToDoItem] {
        return todoListRepository.fetchToDoList()
    }

    func updateToDoItem(
        _ id: UUID,
        isChecked: Bool,
        routine: String,
        icon: String,
        priority: Priority
    ) throws {
        try todoListRepository.updateToDoItem(
            id,
            isChecked: isChecked,
            routine: routine,
            icon: icon,
            priority: priority
        )
    }

    func deleteToDoItem(_ id: UUID) throws {
        try todoListRepository.deleteToDoItem(id)
    }

    func addToDoItem(_ item: ToDoItem) async throws {
        try await todoListRepository.addToDoItem(item: item)
    }

}
