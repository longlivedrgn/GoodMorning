//
//  DefaultCurrentLocationRepository.swift
//  GoodMorning
//
//  Created by Miro on 10/3/23.
//

import Foundation

class DefaultCurrentLocationRepository {

    private let locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }

}

extension DefaultCurrentLocationRepository: CurrentLocationRepository {

    func fetchCurrentLocation() -> Result<Coordinate?, LocationError>? {
        let group = DispatchGroup()
        var coreLocationResult: Result<Coordinate?, LocationError>?

        group.enter()
        locationManager.fetchCurrentLocation { coordinate, error in
            if let error = error {
                coreLocationResult = .failure(error)
            } else {
                coreLocationResult = .success(coordinate)
            }
            group.leave()
        }
        group.wait()

        return coreLocationResult
    }

}
