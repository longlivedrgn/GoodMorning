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
        let dispatchGroup = DispatchGroup()
        var result: EntityType?

        dispatchGroup.enter()
        let createWork = DispatchWorkItem {
            let managedEntity = backgroundContext.performAndWait {
                let object = EntityType.makeNewObject(in: backgroundContext)
                return object
            }

            result = managedEntity
            dispatchGroup.leave()
        }
        queue.async(execute: createWork)
        dispatchGroup.wait()

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
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
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
            dispatchGroup.leave()
        }

        queue.async(execute: updateWork)
        dispatchGroup.wait()
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

}
