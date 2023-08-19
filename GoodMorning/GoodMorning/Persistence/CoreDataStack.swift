//
//  CoreDataStack.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import CoreData
import UIKit

struct CoreDataStack: PersistentStore {

    private var container: NSPersistentContainer
    private let queue: DispatchQueue
    private var backgroundContext: NSManagedObjectContext

    init(container: Container) {
        self.container = NSPersistentContainer(name: container.name)
        self.queue = DispatchQueue(label: container.name)
        self.backgroundContext = self.container.newBackgroundContext()
        initiateContainer()
    }

    private func initiateContainer() {
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                container.viewContext.configureViewContext()
                backgroundContext.configureBackgroundContext()
            }
        }
    }

    func create<EntityType: ManagedEntity>() -> EntityType? {
        var result: EntityType?

        print("1: \(Thread.current)")
        let createWork = DispatchWorkItem {
            print("2: \(Thread.current)")
            let managedEntity = backgroundContext.performAndWait {
                print("3: \(Thread.current)")
                let object = EntityType.makeNewObject(in: backgroundContext)
                return object
            }
            result = managedEntity
        }
        queue.asyncAndWait(execute: createWork)

        return result
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

    func update() {
        let updateWork = DispatchWorkItem {
            backgroundContext.performAndWait {
                if backgroundContext.hasChanges {
                    do {
                        try backgroundContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }

        queue.asyncAndWait(execute: updateWork)
    }

}

extension CoreDataStack {

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
