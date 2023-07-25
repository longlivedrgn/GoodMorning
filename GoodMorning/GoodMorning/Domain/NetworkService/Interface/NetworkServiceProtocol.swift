//
//  NetworkServiceProtocol.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/24.
//

protocol NetworkServiceProtocol {

    func request<Endpoint: RequestResponsable>(
        _ endpoint: Endpoint
    ) async throws -> Result<Endpoint.Response, NetworkError>

}