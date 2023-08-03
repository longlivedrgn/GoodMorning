//
//  JSONLoader.swift
//  GoodMorningTests
//
//  Created by Sunny on 2023/07/30.
//

import Foundation

final class JSONLoader {
    
    private enum NetworkTestError: Error {
        case isNotFoundJSONFile
    }

    func load(fileName: String) throws -> URL {

        let bundle = Bundle(for: Self.self)
        guard let fileURL = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NetworkTestError.isNotFoundJSONFile
        }
        return fileURL
    }
}
