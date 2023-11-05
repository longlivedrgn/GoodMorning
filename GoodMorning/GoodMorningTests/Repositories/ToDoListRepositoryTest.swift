//
//  ToDoListRepositoryTest.swift
//  GoodMorningTests
//
//  Created by Sunny on 11/3/23.
//

import XCTest
@testable import GoodMorning

final class ToDoListRepositoryTest: XCTestCase {
    
    var sut: ToDoListRepository!

    let id: String = "C5CB1104-2237-477A-B311-583BD8D7FECA"

    override func setUpWithError() throws {
        let coreDataStack = DefaultCoreDataStack(container: .goodMorning)
        sut = DefaultToDoListRepository(coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_새로운_ToDoItem_추가하기() async throws {
        let newItem = ToDoItem(
            iconImage: nil,
            description: "새로운 아이템 1",
            isChecked: false,
            priority: .low
        )

        try await sut.addToDoItem(item: newItem)

        let morningRoutines = sut.fetchToDoList()
        print("test/ entities: \(morningRoutines)")
    }

    func test_기존의_ToDoItem을_업데이트하기() async throws {
        try sut.updateToDoItem(
            self.id,
            isChecked: true,
            routine: "새로운 아이템 4",
            icon: nil,
            priority: .high
        )

        let updatedMorningRoutines = sut.fetchToDoList()
        print("test/ updated entities: \(updatedMorningRoutines)")
    }

    func test_모든_ToDoList_fetch하기() {
        let morningRoutines = sut.fetchToDoList()
        print(morningRoutines)
    }

}
