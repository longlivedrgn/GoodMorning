//
//  JSONDeserializer.swift
//  GoodMorning
//
//  Created by 김용재 on 2023/07/14.
//

import Foundation

struct JSONDeserializer: JSONDeserializable {

    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }

}
