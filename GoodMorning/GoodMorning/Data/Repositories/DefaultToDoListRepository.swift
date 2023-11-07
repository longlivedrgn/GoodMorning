//
//  DefaultToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

import Foundation

enum CoreDataError: Error {
    case failToMakeEntity
    case failToFindEntity
}

final class DefaultToDoListRepository: ToDoListRepository {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

}

extension DefaultToDoListRepository {

    func fetchToDoList() -> [ToDoItem] {
        let morningRoutine: [MorningRoutine] = coreDataStack.fetch()
        let item = morningRoutine.map { routine in
            ToDoItem(
                iconImage: routine.icon,
                description: routine.description,
                isChecked: routine.isChecked,
                priority: routine.priority
            )
        }

        return item
    }

    func addToDoItem(item: ToDoItem) async throws {
        guard let entity: MorningRoutine = await coreDataStack.create() else {
            throw CoreDataError.failToMakeEntity
        }
        entity.isChecked = item.isChecked
        entity.routine = item.description
        entity.icon = item.iconImage
        entity.priority = item.priority
        entity.identifier = item.identifier

        coreDataStack.save()
    }

    func deleteToDoItem(_ id: UUID) throws {
        let morningRoutine = fetchMorningRoutine(id)

        guard let deleteItem = morningRoutine else {
            throw CoreDataError.failToFindEntity
        }

        coreDataStack.delete(deleteItem)
        coreDataStack.save()
    }

    func updateToDoItem(
        _ id: UUID,
        isChecked: Bool,
        routine: String,
        icon: String?,
        priority: Priority
    ) throws {
        let morningRoutine = fetchMorningRoutine(id)

        guard let updateItem = morningRoutine else {
            throw CoreDataError.failToFindEntity
        }

        updateItem.isChecked = isChecked
        updateItem.routine = routine
        updateItem.icon = icon
        updateItem.priority = priority

        coreDataStack.save()
    }

}

extension DefaultToDoListRepository {

    private func fetchMorningRoutine(_ id: UUID) -> MorningRoutine? {
        guard let morningRoutine: MorningRoutine = coreDataStack.fetch(id: id) else {
            return nil
        }

        return morningRoutine
    }

}
