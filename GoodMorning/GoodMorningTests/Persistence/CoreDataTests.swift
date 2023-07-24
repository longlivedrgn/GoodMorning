//
//  CoreDataTests.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/17.
//

import XCTest
import CoreData
@testable import GoodMorning

final class CoreDataTests: CoreDataTestSetup {

    func test_context가_잘로드되는지() {
        let fetchedObjects: [MorningRoutine] = sut.fetch()
        XCTAssertNotNil(fetchedObjects)
    }

    func test_manangedObject_추가하기() {
        guard let newObject: MorningRoutine = sut?.create() else { return }
        let fetchedObjects: [MorningRoutine] = sut.fetch()
        XCTAssertNotNil(fetchedObjects)
    }

    func test_fetch하기() {
        guard let newObject: MorningRoutine = sut?.create() else { return }
        newObject.routine = "물마시기"
        newObject.isChecked = false
        let fetchedObjects: [MorningRoutine] = sut.fetch()
        XCTAssertTrue(fetchedObjects.first!.routine == "물마시기")
    }
}
