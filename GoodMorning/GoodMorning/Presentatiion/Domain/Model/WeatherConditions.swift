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
    case snow = "snowflake"
    case atmosphere = "cloud.fog.fill"
    case clear = "sun.max.fill"

    var range: ClosedRange<Int> {
        switch self {
        case .thunderstorm:
            return 200...232
        case .drizzle:
            return 300...321
        case .snow:
            return 600...622
        case .atmosphere:
            return 701...781
        case .clear:
            return 800...800
        }
    }

    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }

    enum Rain: String {
        case rain = "cloud.sun.rain.fill"
        case freezing = "snowflake"
        case shower = "cloud.rain.fill"

        var range: ClosedRange<Int> {
            switch self {
            case .rain:
                return 500...504
            case .freezing:
                return 511...511
            case .shower:
                return 520...531
            }
        }

        var image: UIImage? {
            return UIImage(systemName: self.rawValue)
        }
    }

    enum Cloud: String {
        case few = "cloud.sun.fill"
        case scattered = "cloud.fill"
        case broken = "smoke.fill"

        var range: ClosedRange<Int> {
            switch self {
            case .few:
                return 801...801
            case .scattered:
                return 802...802
            case .broken:
                return 803...804
            }
        }

        var image: UIImage? {
            return UIImage(systemName: self.rawValue)
        }
    }

}
