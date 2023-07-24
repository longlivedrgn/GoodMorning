//
//  CoreDataStack.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/16.
//

import CoreData

struct CoreDataStack: PersistentStore {

    private var container: NSPersistentContainer

    init(container: Container) {
        self.container = NSPersistentContainer(name: container.name)
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
        let object = T.makeNewObject(in: container.viewContext)
        return object
    }

    func fetch<T: ManagedEntity>() -> [T] {
        do {
            let request = T.makeNewFetchRequest()
            let fetchResult = try container.viewContext.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func update() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
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