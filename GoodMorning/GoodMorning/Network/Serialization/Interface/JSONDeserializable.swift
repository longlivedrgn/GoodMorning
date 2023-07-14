//
//  JSONDeserializable.swift
//  GoodMorning
//
//  Created by 김용재 on 2023/07/14.
//

import Foundation

protocol JSONDeserializable {

    func deserialize<T: Decodable>(_ data: Data) throws -> T

}
