//
//  PersistentStore.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/24.
//

import Foundation

protocol PersistentStore {
    func create<T: ManagedEntity>() -> T?
    func fetch<T: ManagedEntity>() -> [T]
    func update()
}
