//
//  CurrentWeatherDTO.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//
import Foundation

struct CurrentWeatherDTO: Decodable {

    let temperature: TemperatureDTO
    let weather: [WeatherDTO]

    enum CodingKeys: String, CodingKey {
        case temperature = "main"
        case weather
    }

}
