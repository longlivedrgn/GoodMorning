//
//  GoodMorningDIContainer.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import UIKit

final class GoodMorningDIContainer: GoodMorningFlowCoordinatorDependencies {


    struct Dependencies {
        let networkService: NetworkService
        let locationManager: LocationManager
    }

    private let dependencies: Dependencies

    // MARK: Persistent Storage
    // Core Data 객체가 여기에 들어가네?..

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
    func makeHomeSceneViewController(actions: HomeSceneViewModelActions) -> HomeViewController {
        HomeViewController(viewModel: makeHomeSceneViewModel(actions: actions))
    }

    func makeHomeSceneViewModel(actions: HomeSceneViewModelActions) -> HomeSceneViewModel {
        HomeSceneViewModel(
            fetchCurrentWeatherUseCase: makeFetchCurrentWeatherUseCase(),
            actions: actions
        )
    }

    // MARK: - ToDoModalViewController

    func makeToDoModalViewController(toDoItem: ToDoItem) -> TODOModalViewController {
        return TODOModalViewController()
    }


    // MARK: Flow Coordinators
//    func makeHomeSceneFlowCoordinator(navigationController: UINavigationController)
    func makeGoodMorningFlowCoordinator(
        navigationController: UINavigationController
    ) -> GoodMorningFlowCoordinator {
        GoodMorningFlowCoordinator(navigationController: navigationController, dependencies: self)
    }

}
