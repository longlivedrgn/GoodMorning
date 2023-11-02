//
//  FetchCurrentWeatherUseCase.swift
//  GoodMorning
//
//  Created by Miro on 11/2/23.
//

import Foundation

final class FetchCurrentWeatherUseCase {

    private let weatherRepository: WeatherRepository
    private let locationRepository: CurrentLocationRepository

    init(weatherRepository: WeatherRepository, locationRepository: CurrentLocationRepository) {
        self.weatherRepository = weatherRepository
        self.locationRepository = locationRepository
    }

    func execute() async throws -> CurrentWeather {

        let locationResult = locationRepository.fetchCurrentLocation()

        switch locationResult {
        case .success(let coordinate):
            let currentWeatherResult = try await weatherRepository.fetchCurrentWeather(
                in: coordinate ?? Coordinate(longitude: "0", latitude: "0")
            )

            switch currentWeatherResult {
            case .success(let weather):
                return weather
            case .failure(let networkError):
                throw networkError
            }

        case .failure(let error):
            throw error
        case .none:
            throw LocationError.unknowned
        }
    }

}
