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
            guard let coordinate else { throw LocationError.unknowned }
            let currentWeather = try await currentWeather(in: coordinate)

            return currentWeather

        case .failure(let error):
            throw error
        case .none:
            throw LocationError.unknowned
        }
    }

    func currentWeather(in coordinate: Coordinate) async throws -> CurrentWeather {
        let currentWeatherResult = try await weatherRepository.fetchCurrentWeather(in: coordinate)

        switch currentWeatherResult {
        case .success(let weather):
            return weather
        case .failure(let error):
            throw error
        }
    }

}
