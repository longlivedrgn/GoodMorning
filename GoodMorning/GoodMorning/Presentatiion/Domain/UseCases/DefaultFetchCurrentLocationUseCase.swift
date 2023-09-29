//
//  DefaultFetchCurrentLocationUseCase.swift
//  GoodMorning
//
//  Created by Miro on 9/29/23.
//

import Foundation

protocol FetchCurrentLocationUseCase {
    func execute(handler: @escaping (Coordinate) -> Void)
}

final class DefaultFetchCurrentLocationUseCase: FetchCurrentLocationUseCase {

    private let currentLocationRepository: CurrentLocationRepository

    init(currentLocationRepository: CurrentLocationRepository) {
        self.currentLocationRepository = currentLocationRepository
    }

    // 추후에 Core Location도 asyn await으로 바꿔주기!..
    func execute(handler: @escaping (Coordinate) -> Void) {
        currentLocationRepository.fetchCurrentLocation { coordinate in
            // unwrapping 바꿔주기!..
            handler(coordinate ?? Coordinate(longitude: "0", latitude: "0"))
        }
    }

}
