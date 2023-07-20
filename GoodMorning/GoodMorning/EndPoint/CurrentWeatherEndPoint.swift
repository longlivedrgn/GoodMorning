//
//  CurrentWeatherEndPoint.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/20.
//

import Foundation

struct CurrentWeatherEndPoint: RequestResponsable {

    typealias Response = CurrentWeatherDTO

    var baseURL: String
    var path: String
    var query: [URLQueryItem]?
    var headers: [String: String]?

    init(coordinate: Coordinate) {
        let api = OpenWeatherAPI.currentWeather(coordinate)

        self.baseURL = OpenWeatherAPI.baseURL
        self.path = api.path
        self.query = api.query
    }

}
