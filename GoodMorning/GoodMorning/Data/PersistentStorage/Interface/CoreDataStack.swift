//
//  CoreDataStack.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

protocol CoreDataStack {

    func create<EntityType: ManagedEntity>() -> EntityType?
    func fetch<EntityType: ManagedEntity>() -> [EntityType]
    func update()

}
