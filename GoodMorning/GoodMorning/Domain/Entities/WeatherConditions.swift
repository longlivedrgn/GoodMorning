//
//  WeatherConditions.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/11.
//

import UIKit

enum WeatherConditions: String {

    case thunderstorm = "cloud.bolt.fill"
    case drizzle = "cloud.drizzle.fill"
    case snow, freezing = "snowflake"
    case atmosphere = "cloud.fog.fill"
    case clear = "sun.max.fill"

    // Rain
    case rain = "cloud.sun.rain.fill"
    case shower = "cloud.rain.fill"

    // Cloud
    case few = "cloud.sun.fill"
    case scattered = "cloud.fill"
    case broken = "smoke.fill"

    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }

    static func condition(forCode code: Int) -> WeatherConditions? {
        switch code {
        case 200...232:
            return .thunderstorm
        case 300...321:
            return .drizzle
        case 600...622:
            return .snow
        case 701...781:
            return .atmosphere
        case 800...800:
            return .clear
        case 500...504:
            return .rain
        case 511...511:
            return .freezing
        case 520...531:
            return .shower
        case 801...801:
            return .few
        case 802...802:
            return .scattered
        case 803...804:
            return .broken
        default:
            return nil
        }
    }

}
