//
//  DefaultCoreDataStack.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import CoreData

final class DefaultCoreDataStack: CoreDataStack {

    private var container: NSPersistentContainer
    private lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()

    init(container: Container) {
        self.container = NSPersistentContainer(name: container.name)
        initiateContainer()
    }

    private func initiateContainer() {
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                self.container.viewContext.configureViewContext()
                self.backgroundContext = self.container.newBackgroundContext()
                self.backgroundContext.configureBackgroundContext()
            }
        }
    }

    func create<EntityType: ManagedEntity>() async -> EntityType? {
        let managedEntity = await backgroundContext.perform {
            let object = EntityType.makeNewObject(in: self.backgroundContext)
            return object
        }

        return managedEntity
    }

    func fetch<EntityType: ManagedEntity>() -> [EntityType] {
        do {
            let request = EntityType.makeNewFetchRequest()
            let fetchResult = try container.viewContext.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func delete<EntityType: ManagedEntity>(_ entity: EntityType) {
        backgroundContext.perform {
            guard let object = entity as? NSManagedObject else { return }
            self.backgroundContext.delete(object)
        }
    }

    func save() {
        backgroundContext.perform {
            if self.backgroundContext.hasChanges {
                do {
                    try self.backgroundContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension DefaultCoreDataStack {

    enum Container {
        case goodMorning

        var name: String {
            switch self {
            case .goodMorning:
                return "GoodMorning"
            }
        }
    }

    private enum CoreDataStackError: LocalizedError {

        case isFailedToCreateEntity

        var errorDescription: String? {
            switch self {
            case .isFailedToCreateEntity:
                return "Entity 만들기에 실패하였습니다."
            }
        }

    }

}

internal extension NSManagedObjectContext {

    func configureBackgroundContext() {
        mergePolicy = NSOverwriteMergePolicy
    }

    func configureViewContext() {
        automaticallyMergesChangesFromParent = true
        shouldDeleteInaccessibleFaults = true
        mergePolicy = NSRollbackMergePolicy
    }

}
