//
//  ToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

protocol ToDoListRepository {

    func fetchToDoList() -> [ToDoItem]
    func addToDoItem(item: ToDoItem) async throws
    func deleteToDoItem(item: ToDoItem) throws
    func updateToDoItem(item: ToDoItem) throws

}
