//
//  AppDIContainer.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import Foundation

final class AppDIContainer {

    lazy var networkService = NetworkService()
    lazy var locationManager = LocationManager()
    // CoreData는 어떻게 설정을 할 것인가?..
//    lazy var coreDataStack = DefaultCoreDataStack()

    func makeGoodMorningDIContainer() -> GoodMorningDIContainer {
        let dependencies = GoodMorningDIContainer.Dependencies(
            networkService: networkService,
            locationManager: locationManager
        )

        return GoodMorningDIContainer(dependencies: dependencies)
    }

}
