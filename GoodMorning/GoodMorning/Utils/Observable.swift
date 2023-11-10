//
//  Observable.swift
//  GoodMorning
//
//  Created by Miro on 11/8/23.
//

import Foundation


final class Observable<Value> {

    // Observable을 지켜보고 있는 observers들이 있다.
    private var observers = [Observer<Value>]()

    // 자신의 value가 설정되면 자신을 지켜보고 있는 observers들에게 알린다.
    var value: Value {
        didSet { notifyObservers() }
    }

    init(_ value: Value) {
        self.value = value
    }

    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        // observers에 새로운 observer를 append해주고, observerBlock에 value 값 넣어주기
        observers.append(Observer(observer: observer, block: observerBlock))
//        observerBlock(self.value)
    }

    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    // observer의 block에 value 값을 넣어준다.
    private func notifyObservers() {
        for observer in observers {
            observer.block(self.value)
        }
    }

}

