//
//  CoreLocationTest.swift
//  GoodMorningTests
//
//  Created by Miro on 2023/07/18.
//

import XCTest
import CoreLocation
@testable import GoodMorning

final class CoreLocationTest: XCTestCase {

    var sut: LocationManager!
    var locationFetcher: MockLocationFetcher!

    override func setUpWithError() throws {
        super.setUp()
        locationFetcher = MockLocationFetcher()
        locationFetcher.callBack = {
            return (CLLocation(latitude: 10, longitude: 10), nil)
        }
        sut = LocationManager(locationFetcher: locationFetcher)
    }

    override func tearDownWithError() throws {
        sut = nil
        locationFetcher = nil
    }

    func test_임의의_위치를_넣어줬을때_제대로_위치_정보를_가져오는지_확인() {
        let expectationLocation = CLLocation(latitude: 10, longitude: 10)
        var resultLocation: CLLocation?

        sut.fetchCurrentLocation { location, error in
            resultLocation = location
        }
        sut.updateLocation()

        XCTAssertEqual(resultLocation?.coordinate.latitude, expectationLocation.coordinate.latitude)
    }

}
