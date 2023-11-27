//
//  DefaultWeatherRepository.swift
//  GoodMorning
//
//  Created by Miro on 10/3/23.
//

import Foundation

class DefaultWeatherRepository {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

}

extension DefaultWeatherRepository: WeatherRepository {

    // 현재 날씨
    func fetchCurrentWeather(
        in coordinate: Coordinate
    ) async throws -> Result<CurrentWeather, NetworkError> {

        let currentWeatherEndPoint = CurrentWeatherEndPoint(coordinate: coordinate)
        let networkResult = try await networkService.request(currentWeatherEndPoint)
        switch networkResult {
        case .success(let currentWeatherDTO):
            let currentWeather = currentWeatherDTO.toDomain()
            return .success(currentWeather)
        case .failure(let error):
            return .failure(error)
        }
    }

    // 오늘의 날씨
    func fetchTodayWeather() {}
}
