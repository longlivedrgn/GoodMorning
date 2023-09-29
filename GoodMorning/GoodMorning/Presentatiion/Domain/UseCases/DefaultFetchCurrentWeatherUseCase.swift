//
//  DefaultFetchCurrentWeatherUseCase.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import Foundation

protocol FetchCurrentWeatherUseCase {
    func execute(value: Coordinate) async throws -> CurrentWeather
}

final class DefaultFetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase {

    private let currentWeatherRepository: CurrentWeatherRepository

    init(currentWeatherRepository: CurrentWeatherRepository) {
        self.currentWeatherRepository = currentWeatherRepository
    }

    func execute(value: Coordinate) async throws -> CurrentWeather {
        let requestedValue = try await currentWeatherRepository.fetchCurrentWeather(location: value)

        return requestedValue
    }

}
