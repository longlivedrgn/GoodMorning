//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    private let locationManger = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        requestCurrentLocation()
    }

    func requestCurrentLocation() {
        locationManger.fetchCurrentLocation { location, error in
            if let error {
                print(error)
            } else {
                print(location)
            }
        }
    }

}
