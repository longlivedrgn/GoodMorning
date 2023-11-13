//
//  ToDoModalViewModel.swift
//  GoodMorning
//
//  Created by Sunny on 11/13/23.
//

import Foundation

final class ToDoModalViewModel {

    var title: Box<String?> = Box(nil)
    var description: Box<String?> = Box(nil)
    var priority: Box<Int> = Box(0)

    private var item: ToDoItem? = nil

    private let todoListUseCase: ToDoListUseCase

    init(todoListUseCase: ToDoListUseCase) {
        self.todoListUseCase = todoListUseCase
    }

}

// MARK: Functions - Public
extension ToDoModalViewModel {

    func configureToDoItem(_ item: ToDoItem?) {
        self.item = item

        setupToDoItem()
    }

}

// MARK: Functions - Private
extension ToDoModalViewModel {

    private func setupToDoItem() {
        // 새로운 로또를 추가 하기 위해 빈 화면
        guard let item = item else { return }
        self.title.value = item.title
        self.description.value = item.description
        self.priority.value = item.priority.rawValue
    }

}
