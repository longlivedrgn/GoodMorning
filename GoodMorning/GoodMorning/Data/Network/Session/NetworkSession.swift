//
//  NetworkSession.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/14.
//

import Foundation

typealias NetworkResult = Result<Data, NetworkError>

final class NetworkSession {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func data(from urlRequest: URLRequest) async throws -> NetworkResult {
        let (data, response) = try await session.data(for: urlRequest)

        guard response.checkResponse else {
            return .failure(.outOfResponseCode)
        }

        return .success(data)
    }

}
