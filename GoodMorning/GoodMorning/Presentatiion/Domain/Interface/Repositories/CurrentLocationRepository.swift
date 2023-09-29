//
//  CurrentLocationRepository.swift
//  GoodMorning
//
//  Created by Miro on 9/29/23.
//

import Foundation

protocol CurrentLocationRepository {

    func fetchCurrentLocation(handler: @escaping (Coordinate?) -> Void) 

}
