//
//  LocationManager.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/16.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {

    private var coreLocationManager = CLLocationManager()

    override init() {
        super.init()
        coreLocationManager.delegate = self
        coreLocationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailedWithError")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            // alert 구현
            print("denied")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            return
        }
    }
}
