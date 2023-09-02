//
//  Character+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/09/02.
//

extension Character {

    var isEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else {
            return false
        }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

}
