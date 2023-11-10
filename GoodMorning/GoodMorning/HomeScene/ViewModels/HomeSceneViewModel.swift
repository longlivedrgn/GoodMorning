//
//  HomeSceneViewModel.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation

class HomeSceneViewModel {
    private let fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase
    // Default 값을 어떻게 줄 지를 고민해봐야될 것 같다...
    // init으로 받아서 ViewController에서 만들어줄지도?..
    let currentWeather: Observable<CurrentWeather?> = Observable(nil)

    init(fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase) {
        self.fetchCurrentWeatherUseCase = fetchCurrentWeatherUseCase
        fetchCurrentWeather()
    }

    func fetchCurrentWeather() {
        Task {
            let fetchedWeather = try await fetchCurrentWeatherUseCase.execute()
            currentWeather.value = fetchedWeather
            print(fetchedWeather)
        }
    }

}
