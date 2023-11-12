//
//  ToDoModalViewModel.swift
//  GoodMorning
//
//  Created by Sunny on 11/13/23.
//

import Foundation

final class ToDoModalViewModel {

    private let todoListUseCase: ToDoListUseCase

    private var itemId: UUID? = nil

    init(todoListUseCase: ToDoListUseCase) {
        self.todoListUseCase = todoListUseCase
    }

}

// MARK: Functions - Public
extension ToDoModalViewModel {

    func configureToDoItem(_ item: UUID?) {
        self.itemId = item

        print("ViewModel: \(item)")
    }

}
