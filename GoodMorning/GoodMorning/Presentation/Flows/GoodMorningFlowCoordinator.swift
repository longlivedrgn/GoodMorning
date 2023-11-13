//
//  GoodMorningFlowCoordinator.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import UIKit

protocol GoodMorningFlowCoordinatorDependencies {
    func makeHomeSceneViewController(actions: HomeSceneViewModelActions) -> HomeViewController
    func makeToDoModalViewController(toDoItem: ToDoItem) -> TODOModalViewController
//    func makeWeatherViewController() -> 날씨 ViewController 생성
    // 운세 ViewController 생성
}

final class GoodMorningFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: GoodMorningFlowCoordinatorDependencies

    init(
        navigationController: UINavigationController,
        dependencies: GoodMorningFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        // 시작점은 HomeScene으로 구성하기
        let actions = HomeSceneViewModelActions(showToDoModal: showToDoModal)
        let viewController = dependencies.makeHomeSceneViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: false)
    }

    // ToDoModal을 보여주는 함수!
    func showToDoModal(toDoItem: ToDoItem) {
        let viewController = dependencies.makeToDoModalViewController(toDoItem: toDoItem)
        navigationController?.pushViewController(viewController, animated: false)
    }

    // 날씨 Scene으로 넘어가는 함수!
//    func showWeatherScene() {
//        let viewController = dependencies.()
//
//    }
}

