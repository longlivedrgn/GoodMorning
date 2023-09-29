//
//  DefaultFetchCurrentLocationRepository.swift
//  GoodMorning
//
//  Created by Miro on 9/29/23.
//

import Foundation

final class DefaultFetchCurrentLocationRepository {

    private let locationManager = LocationManager()

}


extension DefaultFetchCurrentLocationRepository: CurrentLocationRepository {

    func fetchCurrentLocation(handler: @escaping (Coordinate?) -> Void) {
        locationManager.fetchCurrentLocation { coordinate, error in
            handler(coordinate)
        }
    }

}
