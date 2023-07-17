//
//  LocationManager.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/16.
//

import CoreLocation

final class LocationManager: NSObject {

    private var locationFetcher: LocationFetcher
    var lastLocation: ((CLLocation?) -> Void)?

    init(locationFetcher: LocationFetcher = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        super.init()
        self.locationFetcher.locationFetcherDelegate = self
    }

}

extension LocationManager: LocationFetcherDelegate {

    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]) {
        lastLocation?(locations.last)
    }

    func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error) {
        print(error)
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
