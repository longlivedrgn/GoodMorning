//
//  TemperatureDTO.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/24.
//
import Foundation

struct TemperatureDTO: Decodable {

    let averageTemperature, minimumTemperature, maximumTemperature: Double

    enum CodingKeys: String, CodingKey {
        case averageTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }

}
