//
//  AppDIContainer.swift
//  GoodMorning
//
//  Created by Miro on 11/13/23.
//

import Foundation

final class AppDIContainer {

    var networkService = NetworkService()
    var locationManager = LocationManager()
    // CoreData는 어떻게 설정을 할 것인가?..
    var coreDataStack = DefaultCoreDataStack(container: .goodMorning)

    func makeGoodMorningDIContainer() -> GoodMorningDIContainer {
        let dependencies = GoodMorningDIContainer.Dependencies(
            networkService: networkService,
            locationManager: locationManager,
            coreDataStack: coreDataStack
        )

        return GoodMorningDIContainer(dependencies: dependencies)
    }

}
