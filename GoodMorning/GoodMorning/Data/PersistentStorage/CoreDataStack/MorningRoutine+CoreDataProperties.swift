//
//  MorningRoutine+CoreDataProperties.swift
//  
//
//  Created by Sunny on 2023/10/03.
//
//

import Foundation
import CoreData

extension MorningRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MorningRoutine> {
        return NSFetchRequest<MorningRoutine>(entityName: "MorningRoutine")
    }

    @NSManaged public var title: String?
    @NSManaged public var isChecked: Bool
    @NSManaged public var routine: String?
    @NSManaged public var icon: String?
    @NSManaged private var priorityValue: Int32
    @NSManaged public var identifier: UUID

    var priority: Priority {
        get {
            return Priority(rawValue: Int(priorityValue)) ?? .medium
        }
        set {
            priorityValue = Int32(newValue.rawValue)
        }
    }

}

extension MorningRoutine: ManagedEntity { }
