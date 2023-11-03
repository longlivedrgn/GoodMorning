//
//  ToDoListUseCase.swift
//  GoodMorning
//
//  Created by Sunny on 11/3/23.
//

import Foundation

final class ToDoListUseCase {

    private let todoListRepository: ToDoListRepository

    init(todoListRepository: ToDoListRepository) {
        self.todoListRepository = todoListRepository
    }

    func fetchToDoList() -> [TODOItem] {
        return todoListRepository.fetchToDoList()
    }

    func updateToDoItem(_ item: TODOItem) throws {
        try todoListRepository.updateToDoItem(item: item)
    }

    func deleteToDoItem(_ item: TODOItem) throws {
        try todoListRepository.deleteToDoItem(item: item)
    }

    func addToDoItem(_ item: TODOItem) async throws {
        try await todoListRepository.addToDoItem(item: item)
    }
    
}
