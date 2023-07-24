//
//  Coordinate.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//

import Foundation

struct Coordinate: Decodable {

    let longitude: String
    let latitude: String

    lazy var urlQueryItem: [URLQueryItem] = [
        URLQueryItem(name: "lat", value: latitude),
        URLQueryItem(name: "lon", value: longitude)
    ]

}
