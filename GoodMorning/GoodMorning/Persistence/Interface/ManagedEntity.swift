//
//  ManagedEntity.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/17.
//

import CoreData

protocol ManagedEntity: NSFetchRequestResult {
    static func makeNewObject(in context: NSManagedObjectContext) -> Self?
    static func makeNewFetchRequest() -> NSFetchRequest<Self>
}

extension ManagedEntity {
    static var name: String {
        return String(describing: Self.self)
    }

    static func makeNewObject(in context: NSManagedObjectContext) -> Self? {
        let object = NSEntityDescription.insertNewObject(forEntityName: name,
                                                         into: context) as? Self
        return object
    }

    static func makeNewFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest(entityName: name)
    }
}
