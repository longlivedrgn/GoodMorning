//
//  MockLocationFetcher.swift
//  GoodMorningTests
//
//  Created by Miro on 2023/07/18.
//

import CoreLocation
@testable import GoodMorning

class MockLocationFetcher: LocationFetcher {

    var locationFetcherDelegate: GoodMorning.LocationFetcherDelegate?
    var locationCallBackValue: CLLocation?
    var locationErrorCallBackValue: Error?

    func startUpdatingLocation() {
        if let locationErrorCallBackValue {
            locationFetcherDelegate?.locationFetcher(self, didFailWithError: locationErrorCallBackValue)
        } else {
            guard let location = locationCallBackValue else { return }
            locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
        }
    }

    func requestWhenInUseAuthorization() {}

    func requestAlwaysAuthorization() {}

}
