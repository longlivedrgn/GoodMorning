//
//  Observer.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation

struct Observer<Value> {

    weak var observer: AnyObject?
    let block: (Value) -> Void

}
