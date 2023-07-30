//
//  NetworkServiceTests.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import XCTest
@testable import GoodMorning

class NetworkSessionTests: XCTestCase {

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


    func test_statusCode가_200이고_데이터가_존재할때() async throws {
        let urlSession = MockURLSession(data: data, statusCode: 200, url: url)
        let networkSession = MockNetworkSession(session: urlSession)

        let urlRequest = URLRequest(url: url)
        let result = try await networkSession.data(from: urlRequest)

        let expectation: NetworkResult = .success(data)
        XCTAssertEqual(result, expectation)
    }

    func test_statusCode가_200번대가_아닐때() async throws {
        let urlSession = MockURLSession(data: nil, statusCode: 300, url: url)
        let networkSession = MockNetworkSession(session: urlSession)

        let urlRequest = URLRequest(url: url)
        let result = try await networkSession.data(from: urlRequest)
        let expectation: NetworkResult = .failure(.outOfResponseCode)
        XCTAssertEqual(result, expectation)
    }
}

