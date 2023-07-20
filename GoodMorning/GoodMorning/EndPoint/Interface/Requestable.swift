//
//  Requestable.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//
import Foundation

protocol Requestable {

    var path: String { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String]? { get }

}

extension Requestable {

    var httpMethod: String {
        return "get"
    }

    private var urlComponents: URL? {
        var components = URLComponents()
        components.path = self.path
        components.queryItems = self.query

        return components.url
    }

    func makeRequest() throws -> URLRequest {
        // NetworkError와 연결하기
        guard let url = self.urlComponents else {
            throw fatalError()
        }

        var request = URLRequest(url: url)

        self.headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        request.httpMethod = self.httpMethod

        return request
    }

}
