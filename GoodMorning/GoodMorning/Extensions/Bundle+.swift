//
//  Bundle+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/14.
//

import Foundation

extension Bundle {

    var openWeatherAPIKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["OpenWeatherAPIKey"] as? String else {
            print(NetworkError.notFoundAPIKey.localizedDescription)
            return nil
        }
        return key
    }

}
