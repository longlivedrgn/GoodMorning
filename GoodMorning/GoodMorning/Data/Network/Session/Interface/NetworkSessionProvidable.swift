//
//  NetworkSessionProvidable.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/30.
//

import Foundation

typealias NetworkResult = Result<Data, NetworkError>

protocol NetworkSessionProvidable {
    
    func data(from urlRequest: URLRequest) async throws -> NetworkResult
    
}
