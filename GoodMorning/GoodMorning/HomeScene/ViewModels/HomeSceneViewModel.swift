//
//  HomeSceneViewModel.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation

class HomeSceneViewModel {
    private let fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase

    init(fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase) {
        self.fetchCurrentWeatherUseCase = fetchCurrentWeatherUseCase
    }
}
