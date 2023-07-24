//
//  CoreDataTestSetup.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/23.
//

import XCTest
@testable import GoodMorning

class CoreDataTestSetup: XCTestCase {

    var sut: PersistentStore!

    override func setUpWithError() throws {
        sut = CoreDataStack(container: .goodMorning)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
