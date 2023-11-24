//
//  GoodMorningFlowCoordinator.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import UIKit

final class GoodMorningFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: GoodMorningDIContainer

    init(
        navigationController: UINavigationController,
        dependencies: GoodMorningDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.makeHomeSceneViewController()
        viewController.actions = HomeViewController.Actions.init(
            showToDoModal: showToDoModal,
            showWeatherDetailView: showWeatherDetailView
        )
        navigationController?.pushViewController(viewController, animated: false)
    }

    func showToDoModal(toDoItem: ToDoItem?) {
        let viewController = dependencies.makeToDoModalViewController(toDoItem: toDoItem)
        navigationController?.pushViewController(viewController, animated: false)
    }

    func showWeatherDetailView(currentWeather: CurrentWeather?) {
        //
    }

}
