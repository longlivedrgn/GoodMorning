//
//  UICellConfigurationState.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/08.
//

import UIKit

extension UICellConfigurationState {

    var item: TODOItem? {
        get {
            return self[UIConfigurationStateCustomKey.item] as? TODOItem
        }
        set {
            self[UIConfigurationStateCustomKey.item] = newValue
        }
    }

}
