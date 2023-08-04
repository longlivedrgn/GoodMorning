//
//  CLLocationManager.swift
//  GoodMorning
//
//  Created by Miro on 2023/07/17.
//

import CoreLocation

extension CLLocationManager: LocationFetchable {

    var locationFetcherDelegate: LocationFetcherDelegate? {
        get {
            return delegate as? LocationFetcherDelegate
        }
        set {
            delegate = newValue as? CLLocationManagerDelegate
        }
    }

}
