//
//  NetworkTestSetup.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/31.
//

import XCTest
@testable import GoodMorning

class NetworkTestSetup: XCTestCase {

    var data: Data!
    var url: URL!

    override func setUpWithError() throws {
        let jsonLoader = JSONLoader()
        let fileURL = try jsonLoader.load(fileName: "CurrentWeather")
        data = try Data(contentsOf: fileURL)
        url = URL(string: "https://api.test.com")
    }

    override func tearDownWithError() throws {
        data = nil
        try super.tearDownWithError()
    }

}
