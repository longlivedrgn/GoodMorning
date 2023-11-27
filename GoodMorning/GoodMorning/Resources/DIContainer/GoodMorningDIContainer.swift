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
        let coreDataStack: CoreDataStack
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

    func makeToDoListUseCase() -> ToDoListUseCase {
        ToDoListUseCase(todoListRepository: makeToDoListRepository())
    }

    // MARK: - Repositories
    func makeweatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(networkService: dependencies.networkService)
    }

    func makeCurrentLocationRepository() -> CurrentLocationRepository {
        DefaultCurrentLocationRepository(locationManager: dependencies.locationManager)
    }

    func makeToDoListRepository() -> ToDoListRepository {
        DefaultToDoListRepository(coreDataStack: dependencies.coreDataStack)
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

    func makeToDoModalViewController(toDoItem: ToDoItem?) -> ToDoModalViewController {
        return ToDoModalViewController(viewModel: makeToDoModalViewModal())
    }

    func makeToDoModalViewModal() -> ToDoModalViewModel {
        ToDoModalViewModel(todoListUseCase: makeToDoListUseCase())
    }

    // MARK: Flow Coordinators
    func makeGoodMorningFlowCoordinator(
        navigationController: UINavigationController
    ) -> GoodMorningFlowCoordinator {
        GoodMorningFlowCoordinator(navigationController: navigationController, dependencies: self)
    }

}
