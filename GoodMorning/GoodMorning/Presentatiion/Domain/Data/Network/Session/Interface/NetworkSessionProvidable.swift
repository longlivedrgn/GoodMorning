//
//  NetworkSessionProvidable.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/03.
//

import Foundation

typealias NetworkResult = Result<Data, NetworkError>

protocol NetworkSessionProvidable {

    func data(from urlRequest: URLRequest) async throws -> NetworkResult

}
