//
//  HomeSceneViewModel.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation

final class HomeSceneViewModel {

    private let fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase
    let currentWeather: Observable<CurrentWeather?> = Observable(nil)

    init(
        fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase
    ) {
        self.fetchCurrentWeatherUseCase = fetchCurrentWeatherUseCase
        self.fetchCurrentWeather()
    }

    func fetchCurrentWeather() {
        Task {
            let fetchedWeather = try await fetchCurrentWeatherUseCase.execute()
            currentWeather.value = fetchedWeather
            print(fetchedWeather)
        }
    }

}
