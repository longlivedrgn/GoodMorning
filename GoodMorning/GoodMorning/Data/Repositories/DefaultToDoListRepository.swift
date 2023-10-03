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

    func fetchToDoList() -> [TODOItem] {
        let morningRoutine: [MorningRoutine] = coreDataStack.fetch()
        let item = morningRoutine.map { routine in
            TODOItem(
                iconImage: routine.icon,
                description: routine.description,
                isChecked: routine.isChecked,
                priority: routine.priority
            )
        }

        return item
    }

    func addToDoListItem(item: TODOItem) async throws {
        guard let entity: MorningRoutine = await coreDataStack.create() else {
            throw CoreDataError.failToMakeEntity
        }
        entity.isChecked = item.isChecked
        entity.routine = item.description
        entity.icon = item.iconImage
        entity.priority = item.priority
        entity.identifier = item.identifier

        coreDataStack.update()
    }

    func deleteToDoListItem(item: TODOItem) throws {
        let morningRoutines: [MorningRoutine] = coreDataStack.fetch()
        let morningRoutine = morningRoutines.filter { $0.identifier == item.identifier}

        guard let deleteItem = morningRoutine.first else {
            throw CoreDataError.failToFindEntity
        }

        coreDataStack.delete(deleteItem)
    }

}
