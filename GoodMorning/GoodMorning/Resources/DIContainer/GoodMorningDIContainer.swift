//
//  GoodMorningDIContainer.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import UIKit

final class GoodMorningDIContainer {

    struct Dependencies {
        let networkService: NetworkService
        let locationManager: LocationManager
    }

    private let dependencies: Dependencies

    // MARK: Persistent Storage
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeFetchCurrentWeatherUseCase() -> FetchCurrentWeatherUseCase {
        FetchCurrentWeatherUseCase(
            weatherRepository: makeweatherRepository(),
            locationRepository: makeCurrentLocationRepository()
        )
    }

    // MARK: - Repositories
    func makeweatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(networkService: dependencies.networkService)
    }

    func makeCurrentLocationRepository() -> CurrentLocationRepository {
        DefaultCurrentLocationRepository(locationManager: dependencies.locationManager)
    }

    // MARK: - ModalViewController
    func makeHomeSceneViewController() -> HomeViewController {
        HomeViewController(viewModel: makeHomeSceneViewModel())
    }

    func makeHomeSceneViewModel() -> HomeSceneViewModel {
        HomeSceneViewModel(
            fetchCurrentWeatherUseCase: makeFetchCurrentWeatherUseCase()
        )
    }

    // MARK: - ToDoModalViewController

    func makeToDoModalViewController(toDoItem: ToDoItem?) -> TODOModalViewController {
        return TODOModalViewController()
    }

    // MARK: Flow Coordinators
    func makeGoodMorningFlowCoordinator(
        navigationController: UINavigationController
    ) -> GoodMorningFlowCoordinator {
        GoodMorningFlowCoordinator(navigationController: navigationController, dependencies: self)
    }

}
