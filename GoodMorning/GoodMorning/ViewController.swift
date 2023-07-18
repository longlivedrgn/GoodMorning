//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {

    private let locationManger = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        requestCurrentLocation()
    }

    func requestCurrentLocation() {
        locationManger.fetchCurrentLocation { location, error in
            guard error == nil else { return }
            print(location)
        }
    }

}
