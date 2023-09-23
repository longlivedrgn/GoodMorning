//
//  MorningRoutine+CoreDataProperties.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/17.
//
//

import Foundation
import CoreData

extension MorningRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MorningRoutine> {
        return NSFetchRequest<MorningRoutine>(entityName: "MorningRoutine")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var routine: String?

}

extension MorningRoutine: Identifiable { }

extension MorningRoutine: ManagedEntity { }
