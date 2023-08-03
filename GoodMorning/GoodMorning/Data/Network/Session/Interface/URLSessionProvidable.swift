//
//  URLSessionProvidable.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/03.
//

import Foundation

protocol URLSessionProvidable {

    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)

}

extension URLSession: URLSessionProvidable {}
