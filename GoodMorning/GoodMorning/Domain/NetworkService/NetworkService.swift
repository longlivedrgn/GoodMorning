//
//  NetworkService.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/24.
//

final class NetworkService: NetworkServiceProvidable {

    private let session: NetworkSessionProvidable
    private let deserializer = JSONDeserializer()

    init(session: NetworkSessionProvidable = NetworkSession()) {
        self.session = session
    }

    func request<Endpoint: RequestResponsable>(
        _ endpoint: Endpoint
    ) async throws -> Result<Endpoint.Response, NetworkError> {
        let request = try endpoint.makeRequest()
        let result = try await session.data(from: request)

        switch result {
        case .success(let data):
            let decodingData: Endpoint.Response = try deserializer.deserialize(data)
            return .success(decodingData)
        case .failure(let error):
            return .failure(error)
        }
    }

}
