//
//  FetchCurrentWeatherUseCase.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import Foundation

final class FetchCurrentWeatherUseCase: UseCase {

    private let currentWeatherRepository: CurrentWeatherRepository

    init(currentWeatherRepository: CurrentWeatherRepository) {
        self.currentWeatherRepository = currentWeatherRepository
    }

    func execute() {
//        return currentWeatherRepository.fetchCurrentWeather()
    }

}
