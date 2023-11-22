//
//  Observable.swift
//  GoodMorning
//
//  Created by Sunny on 11/22/23.
//

final class Observable<Value> {

    private var observers = [Observer<Value>]()

    var value: Value {
        didSet { notifyObservers() }
    }

    init(_ value: Value) {
        self.value = value
    }

    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }

    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            observer.block(self.value)
        }
    }

}
