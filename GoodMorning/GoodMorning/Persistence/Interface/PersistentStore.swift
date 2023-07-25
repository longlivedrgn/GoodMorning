//
//  PersistentStore.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/24.
//

import Foundation

protocol PersistentStore {
    func create<EntityType: ManagedEntity>() -> EntityType?
    func fetch<EntityType: ManagedEntity>() -> [EntityType]
    func update()
}
