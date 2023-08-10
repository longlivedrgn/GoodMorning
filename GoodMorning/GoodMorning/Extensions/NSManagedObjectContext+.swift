//
//  NSManagedObjectContext+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import CoreData

extension NSManagedObjectContext {

    func configureBackgroundContext() {
        mergePolicy = NSOverwriteMergePolicy
    }

    func configureViewContext() {
        automaticallyMergesChangesFromParent = true
        shouldDeleteInaccessibleFaults = true
        mergePolicy = NSRollbackMergePolicy
    }

}
