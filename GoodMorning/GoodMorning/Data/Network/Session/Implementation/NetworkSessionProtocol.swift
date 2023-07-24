//
//  NetworkSessionProtocol.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/25.
//

import Foundation

typealias NetworkResult = Result<Data, NetworkError>

protocol NetworkSessionProtocol {

    func data(from urlRequest: URLRequest) async throws -> NetworkResult

}
