//
//  URLSessionStub.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import Foundation
@testable import GoodMorning

class URLSessionStub: URLSessionProvidable {

    var data: Data?
    var statusCode: Int?
    var url: URL?

    init(data: Data? = nil, statusCode: Int? = nil, url: URL? = nil) {
        self.data = data
        self.statusCode = statusCode
        self.url = url
    }

    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {

        let response = HTTPURLResponse(
            url: url!,
            statusCode: statusCode!,
            httpVersion: nil,
            headerFields: nil
        )

        return (data ?? Data(), response!)
    }

}
