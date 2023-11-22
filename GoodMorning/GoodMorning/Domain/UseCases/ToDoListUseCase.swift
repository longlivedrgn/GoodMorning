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

    func updateToDoItem(_ item: ToDoItem) throws {
        try todoListRepository.updateToDoItem(
            item.identifier,
            title: item.title,
            isChecked: item.isChecked,
            routine: item.description,
            icon: item.iconImage,
            priority: item.priority
        )
    }

    func deleteToDoItem(_ item: ToDoItem) throws {
        try todoListRepository.deleteToDoItem(item.identifier)
    }

    func addToDoItem(_ item: ToDoItem) async throws {
        try await todoListRepository.addToDoItem(item: item)
    }

}
