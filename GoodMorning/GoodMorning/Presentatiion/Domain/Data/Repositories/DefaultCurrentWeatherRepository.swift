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
            let currentWeather = response.toDomain()
            return currentWeather
        case .failure(let error):
            // error 핸들링하기
            throw error
        }
    }

}
