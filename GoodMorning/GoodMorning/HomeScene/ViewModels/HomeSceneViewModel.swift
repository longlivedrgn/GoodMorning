//
//  HomeSceneViewModel.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation

class HomeSceneViewModel {
    private let fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase
    private let actions: HomeSceneViewModelActions?
    // Default 값을 어떻게 줄 지를 고민해봐야될 것 같다...
    // SkeletonView로 잡아버리는 거는 어떨까?..
    let currentWeather: Observable<CurrentWeather?> = Observable(nil)

    init(
        fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase,
        actions: HomeSceneViewModelActions? = nil
    ) {
        self.fetchCurrentWeatherUseCase = fetchCurrentWeatherUseCase
        self.actions = actions
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

// MARK: Input, ViewController에게 들어온 events
extension HomeSceneViewModel {

    func didSelectWeatherView(_ currentWeather: CurrentWeather?) {
        actions?.showWeatherDetailView(currentWeather)

    }

}

// MARK: HomeScene에서 일어나는 Action들
struct HomeSceneViewModelActions {

    let showWeatherDetailView: (CurrentWeather?) -> Void

}
