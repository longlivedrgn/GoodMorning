//
//  CoreDataStack.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import CoreData

struct CoreDataStack {

    private var container: NSPersistentContainer
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    private let containerName = "GoodMorning"

    init() {
        self.container = NSPersistentContainer(name: containerName)
        initiateContainer()
    }

    private func initiateContainer() {
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func create<T: ManagedEntity>() -> T? {
        let object = T.makeNewObject(in: context)
        return object
    }

    func fetch<T: ManagedEntity>() -> [T] {
        do {
            let request = T.makeNewFetchRequest()
            let fetchResult = try context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func update() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
