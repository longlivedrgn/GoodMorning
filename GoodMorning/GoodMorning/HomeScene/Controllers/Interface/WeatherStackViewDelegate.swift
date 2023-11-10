//
//  WeatherStackViewDelegate.swift
//  GoodMorning
//
//  Created by Miro on 11/10/23.
//

import Foundation

protocol WeatherStackViewDelegate: AnyObject {

    func weatherStackView(
        _ WeatherStackView: WeatherStackView,
        didWeatherStackViewTapped sender: WeatherStackView
    )

}
