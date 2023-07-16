//
//  PersistenceTests.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/17.
//

import XCTest
import CoreData
@testable import GoodMorning

final class PersistenceTests: XCTestCase {

    var sut: CoreDataStack!

    override func setUpWithError() throws {
        sut = CoreDataStack()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_context에_추가되었는지() {
        guard let object: MorningRoutine = sut.create() else { return }
        object.routine = "물마시기"
        object.isChecked = false
        let fetchedObjects: [MorningRoutine] = sut.fetch()

        XCTAssertTrue(fetchedObjects.first!.routine == "물마시기")
    }

}
