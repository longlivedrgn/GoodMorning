//
//  LocationFetcherDelegate.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/17.
//

import CoreLocation

protocol LocationFetcherDelegate: AnyObject {

    func locationFetcher(_ fetcher: LocationFetchable, didUpdateLocations locations: [Coordinate])
    func locationFetcher(_ fetcher: LocationFetchable, didFailWithError error: Error)
    func locationFetcher(
        _ fetcher: LocationFetchable,
        didChangeAuthorization authorization: CLAuthorizationStatus
    )

}
