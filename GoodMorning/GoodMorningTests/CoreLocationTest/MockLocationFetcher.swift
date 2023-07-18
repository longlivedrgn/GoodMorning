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
    var callBack: (() -> (CLLocation?, LocationError?))?

    func startUpdatingLocation() {
        guard callBack?().1 == nil else { return }
        guard let location = callBack?().0 else { return }
        locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
    }

    func requestWhenInUseAuthorization() {}

    func requestAlwaysAuthorization() {}

}
