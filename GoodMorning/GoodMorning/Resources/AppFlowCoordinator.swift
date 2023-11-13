//
//  AppFlowCoordinator.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let goodMorningDIContainer = appDIContainer.makeGoodMorningDIContainer()
        let flow = goodMorningDIContainer.makeGoodMorningFlowCoordinator(
            navigationController: navigationController
        )
        flow.start()
    }

}
