//
//  CurrentLocationRepository.swift
//  GoodMorning
//
//  Created by Miro on 10/3/23.
//

import Foundation

protocol CurrentLocationRepository {

    func fetchCurrentLocation() -> Result<Coordinate?, LocationError>?

}
