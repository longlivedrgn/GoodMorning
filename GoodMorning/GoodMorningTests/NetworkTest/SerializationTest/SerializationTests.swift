//
//  SerializationTests.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/31.
//

import XCTest
@testable import GoodMorning

final class SerializationTests: NetworkTestSetup {

    var sut: JSONDeserializable!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = JSONDeserializer()
    }

    func test_deserializer가_잘작동되는지() throws {
        let decodedData: CurrentWeatherDTO = try sut.deserialize(data)

        let expectation: Double = 300.31
        let result = decodedData.temperature.averageTemperature

        XCTAssertEqual(result, expectation)
    }

}
