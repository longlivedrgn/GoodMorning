//
//  NetworkServiceTests.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import XCTest
@testable import GoodMorning

class NetworkSessionTests: NetworkTestSetup {

    func test_statusCode가_200이고_데이터가_존재할때() async throws {
        let urlSession = URLSessionStub(data: data, statusCode: 200, url: url)
        let networkSession = NetworkSession(session: urlSession)

        let urlRequest = URLRequest(url: url)
        let result = try await networkSession.data(from: urlRequest)

        let expectation: NetworkResult = .success(data)
        XCTAssertEqual(result, expectation)
    }

    func test_statusCode가_200번대가_아닐때() async throws {
        let urlSession = URLSessionStub(data: nil, statusCode: 300, url: url)
        let networkSession = NetworkSession(session: urlSession)

        let urlRequest = URLRequest(url: url)
        let result = try await networkSession.data(from: urlRequest)
        let expectation: NetworkResult = .failure(.outOfResponseCode)
        XCTAssertEqual(result, expectation)
    }

}

