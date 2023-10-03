//
//  DefaultToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

import Foundation

final class DefaultToDoListRepository: ToDoListRepository {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

}

extension DefaultToDoListRepository {

    // 1. todo list 목록 가져오기

    // 2. todo list 추가 / 저장

    // 3. todo list 삭제

}
