//
//  ToDoModalViewModel.swift
//  GoodMorning
//
//  Created by Sunny on 11/13/23.
//

import Foundation

final class ToDoModalViewModel {

    var title: Observable<String?> = Observable(nil)
    var description: Observable<String?> = Observable(nil)
    var icon: Observable<String?> = Observable(nil)
    var priority: Observable<Int> = Observable(0)

    private var item: ToDoItem? = nil

    private let todoListUseCase: ToDoListUseCase

    init(todoListUseCase: ToDoListUseCase) {
        self.todoListUseCase = todoListUseCase
    }

}

// MARK: Functions - Public
extension ToDoModalViewModel {

    func configureItem(_ item: ToDoItem?) {
        self.item = item

        setupToDoItem()
    }

    func updateItem(
        title: String?,
        description: String?,
        icon: String?,
        priority: Int
    ) {
        guard var item = self.item else {
            let newItem = ToDoItem(
                iconImage: icon,
                title: title,
                description: description,
                isChecked: false,
                priority: Priority(rawValue: priority) ?? .high
            )
            self.createToDoItem(newItem)
            return
        }

        item.title = title
        item.description = description
        item.iconImage = icon
        item.priority = Priority(rawValue: priority) ?? .high

        self.updateToDoItem()
    }

    func deleteItem() {
        guard let item = item else { return }
        do {
            try self.todoListUseCase.deleteToDoItem(item)
        } catch {
            print(error.localizedDescription)
        }
    }

}

// MARK: Functions - Private
extension ToDoModalViewModel {

    private func setupToDoItem() {
        guard let item = item else { return }
        self.title.value = item.title
        self.description.value = item.description
        self.priority.value = item.priority.rawValue
    }

    private func updateToDoItem() {
        guard let item = item else { return }
        do {
            try self.todoListUseCase.updateToDoItem(item)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func createToDoItem(_ item: ToDoItem) {
        Task {
            do {
                try await self.todoListUseCase.addToDoItem(item)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
