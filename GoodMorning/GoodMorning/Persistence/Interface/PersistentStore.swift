//
//  PersistentStore.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/01.
//

protocol PersistentStore {
    func create<EntityType: ManagedEntity>() -> EntityType?
    func fetch<EntityType: ManagedEntity>() -> [EntityType]
    func update()
}
