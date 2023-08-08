//
//  UIImage+.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

extension UIImage {

    static var checkmark: Self? {
        let SFSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .bold,
            scale: .large
        )
        let SFSymbolImage = UIImage(
            systemName: "checkmark",
            withConfiguration: SFSymbolConfiguration
        )?.withTintColor(.black, renderingMode: .alwaysOriginal)

        return SFSymbolImage as? Self
    }

}
