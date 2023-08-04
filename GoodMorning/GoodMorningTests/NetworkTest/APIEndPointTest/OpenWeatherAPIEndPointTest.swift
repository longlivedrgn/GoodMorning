//
//  OpenWeatherAPIEndPointTest.swift
//  GoodMorningTests
//
//  Created by Miro on 2023/07/20.
//

import XCTest
@testable import GoodMorning

final class OpenWeatherAPIEndPointTest: XCTestCase {

    var currentWeatherEndPoint: CurrentWeatherEndPoint!
    var coordinate: Coordinate!

    override func setUpWithError() throws {
        super.setUp()
        coordinate = Coordinate(longitude: "10", latitude: "10")
        currentWeatherEndPoint = CurrentWeatherEndPoint(coordinate: coordinate)
    }

    override func tearDownWithError() throws {
        coordinate = nil
        currentWeatherEndPoint = nil
        super.tearDown()
    }

    func test_CurrentWeatherAPIEndPoint의_urlRequest가_제대로_생성이_되는가() {
        XCTAssertNoThrow(try currentWeatherEndPoint.makeRequest())
    }

}
