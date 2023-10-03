//
//  LocationManager.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/16.
//

import CoreLocation

final class LocationManager: NSObject {

    typealias LocationCallBack = ((Coordinate?, LocationError?) -> Void)

    private var locationFetcher: LocationFetchable
    var locationCallBack: LocationCallBack?

    init(locationFetcher: LocationFetchable = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        super.init()
        self.locationFetcher.locationFetcherDelegate = self
    }

    func fetchCurrentLocation(completion: @escaping LocationCallBack) {
        self.locationCallBack = completion
    }

    func updateLocation() {
        locationFetcher.startUpdatingLocation()
    }

}

extension LocationManager: LocationFetcherDelegate {

    func locationFetcher(_ fetcher: LocationFetchable, didUpdateLocations locations: [Coordinate]) {
        if let location = locations.first {
            locationCallBack?(location, nil)
        } else {
            locationCallBack?(nil, LocationError.canNotBeLocated)
        }
    }

    func locationFetcher(_ fetcher: LocationFetchable, didFailWithError error: Error) {
        locationCallBack?(nil, LocationError.unknowned)
    }

    func locationFetcher(
        _ fetcher: LocationFetchable,
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
        let coordinates = locations.map {
            Coordinate(
                longitude: String($0.coordinate.longitude), latitude: String($0.coordinate.latitude)
            )
        }
        locationFetcher(manager, didUpdateLocations: coordinates)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationFetcher(manager, didFailWithError: error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationFetcher(manager, didChangeAuthorization: manager.authorizationStatus)
    }

}
