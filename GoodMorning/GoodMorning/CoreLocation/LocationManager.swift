//
//  LocationManager.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/16.
//

import CoreLocation

final class LocationManager: NSObject {

    typealias LocationCallBack = ((CLLocation?, LocationError?) -> Void)

    private var locationFetcher: LocationFetcher
    var locationCallBack: LocationCallBack?

    init(locationFetcher: LocationFetcher = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        super.init()
        self.locationFetcher.locationFetcherDelegate = self
    }

    func fetchCurrentLocation(completion: @escaping LocationCallBack) {
        self.locationCallBack = completion
    }

}

extension LocationManager: LocationFetcherDelegate {

    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationCallBack?(location, nil)
        } else {
            locationCallBack?(nil, .canNotBeLocated)
        }

    }

    func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error) {
        locationCallBack?(nil, .canNotBeLocated)
    }

    func locationFetcher(
        _ fetcher: LocationFetcher,
        didChangeAuthorization authorization: CLAuthorizationStatus
    ) {
        switch authorization {
        case .authorizedWhenInUse:
            fetcher.startUpdatingLocation()
        case .denied, .restricted:
            // alert 구현
            print("denied")
        case .notDetermined:
            fetcher.requestWhenInUseAuthorization()
        default:
            return
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationFetcher(manager, didUpdateLocations: locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationFetcher(manager, didFailWithError: error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationFetcher(manager, didChangeAuthorization: manager.authorizationStatus)
    }

}
