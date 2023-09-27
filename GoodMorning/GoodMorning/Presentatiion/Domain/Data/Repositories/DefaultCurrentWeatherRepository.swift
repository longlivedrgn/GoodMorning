//
//  DefaultCurrentWeatherRepository.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import Foundation

final class DefaultCurrentWeatherRepository {

    private let networkService = NetworkService()

}

extension DefaultCurrentWeatherRepository: CurrentWeatherRepository {

    func fetchCurrentWeather(location: Coordinate) async throws -> CurrentWeather {
        let currentWeatherEndPoint = CurrentWeatherEndPoint(coordinate: location)
        let networkResult = try await networkService.request(currentWeatherEndPoint)

        switch networkResult {
        case .success(let response):
            let currentWeather = convert(response)
            return currentWeather
        case .failure(let error):
            // error 핸들링하기
            throw error
        }
    }

    func convert(_ currentDTO: CurrentWeatherDTO) -> CurrentWeather {
        // 에러 핸들링!...
        let weatherCondition =  WeatherConditions.condition(
            forCode: currentDTO.weather.first?.id ?? 0
        ) ?? WeatherConditions.atmosphere

        return CurrentWeather(
            temperature: currentDTO.temperature.averageTemperature,
            condition: weatherCondition
        )
    }

}
