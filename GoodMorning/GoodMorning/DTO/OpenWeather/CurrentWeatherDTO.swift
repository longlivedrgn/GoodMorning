//
//  CurrentWeatherDTO.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//

import Foundation

struct CurrentWeatherDTO: Decodable {

    let temperature: Temperature
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {

        case temperature = "main"
        case weather
    }

}

struct Temperature: Decodable {

    let averageTemperature, minimumTemperature, maximumTemperature: Double

    enum CodingKeys: String, CodingKey {
        case averageTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }

}

struct Weather: Decodable {

    let icon: String
    
}
