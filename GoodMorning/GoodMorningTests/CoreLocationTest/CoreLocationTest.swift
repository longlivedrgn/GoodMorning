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
        sut = LocationManager(locationFetcher: locationFetcher)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        sut = nil
        locationFetcher = nil
    }

    func test_임의의_위치를_넣어줬을때_제대로_위치_정보를_가져오는지_확인() {
        let expectationLocation = CLLocation(latitude: 10, longitude: 10)
        var resultLocation: CLLocation?

        sut.fetchCurrentLocation { location, error in
            resultLocation = location
        }
        locationFetcher.locationCallBackValue = CLLocation(latitude: 10, longitude: 10)
        locationFetcher.locationErrorCallBackValue = nil
        sut.updateLocation()

        XCTAssertEqual(resultLocation?.coordinate.latitude, expectationLocation.coordinate.latitude)
    }

    func test_네트워크_오류로_로케이션을_받아올_수_없을_때_에러를_던지는지_확인() {
        var coreLocationError: Error?

        sut.fetchCurrentLocation { location, error in
            coreLocationError = error
        }

        locationFetcher.locationErrorCallBackValue = LocationError.canNotBeLocated
        sut.updateLocation()

        XCTAssertNotNil(coreLocationError)
    }

}
