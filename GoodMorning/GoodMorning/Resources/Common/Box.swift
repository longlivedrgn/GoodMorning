//
//  Box.swift
//  GoodMorning
//
//  Created by Sunny on 11/13/23.
//

final class Box<T> {

    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener

        listener?(value)
    }

}
