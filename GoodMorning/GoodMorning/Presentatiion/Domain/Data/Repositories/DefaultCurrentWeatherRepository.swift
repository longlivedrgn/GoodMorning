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
    // 날씨 값 가져오기!..
    func fetchCurrentWeather() {

    }

}
