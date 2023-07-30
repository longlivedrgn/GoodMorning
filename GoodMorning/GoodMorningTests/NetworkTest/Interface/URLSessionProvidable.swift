//
//  URLSessionProvidable.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import Foundation
@testable import GoodMorning

protocol URLSessionProvidable {

    func data(for request: URLRequest) async throws -> (Data, URLResponse)

}
