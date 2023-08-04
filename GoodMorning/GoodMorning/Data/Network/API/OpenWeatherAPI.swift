//
//  OpenWeatherAPI.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//

import Foundation

// 아래는 apiKey가 정의되었다고 가정
extension Bundle {
    static var openWeatherAPIKey = "key"
}

enum OpenWeatherAPI {

    case currentWeather(Coordinate)

    static var baseURL: String {
        return "https://api.openweathermap.org"
    }

    var path: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        }
    }

    var query: [URLQueryItem] {
        var queryItem = [URLQueryItem]()
        let keyParameter = URLQueryItem(name: "appid", value: Bundle.openWeatherAPIKey)
        queryItem.append(keyParameter)

        switch self {
        case .currentWeather(var coordinate):
            let unitParameter = URLQueryItem(name: "units", value: "metric")
            queryItem.append(unitParameter)
            queryItem.append(contentsOf: coordinate.urlQueryItem)
        }

        return queryItem
    }

}
