//
//  MockNetworkSession.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import Foundation
@testable import GoodMorning

class MockNetworkSession: NetworkSessionProvidable {

    private let session: URLSessionProvidable

    init(session: URLSessionProvidable) {
        self.session = session
    }

    func data(from urlRequest: URLRequest) async throws -> GoodMorning.NetworkResult {
        let (data, response) = try await session.data(for: urlRequest)

        guard response.checkResponse else {
            return .failure(.outOfResponseCode)
        }

        return .success(data)
    }

}
