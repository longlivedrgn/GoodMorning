//
//  Observer.swift
//  GoodMorning
//
//  Created by Sunny on 11/22/23.
//

struct Observer<Value> {

    weak var observer: AnyObject?
    let block: (Value) -> Void

}
