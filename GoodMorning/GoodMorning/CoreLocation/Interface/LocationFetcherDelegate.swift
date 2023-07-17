//
//  LocationFetcherDelegate.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/17.
//

import CoreLocation

protocol LocationFetcherDelegate: AnyObject {

    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation])
    func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error)
    func locationFetcher(
        _ fetcher: LocationFetcher,
        didChangeAuthorization authorization: CLAuthorizationStatus
    )

}
