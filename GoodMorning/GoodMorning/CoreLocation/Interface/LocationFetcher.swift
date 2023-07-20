//
//  LocationFetcher.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/17.
//

import CoreLocation

protocol LocationFetcher {

    var locationFetcherDelegate: LocationFetcherDelegate? { get set }

    func startUpdatingLocation()
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()

}
