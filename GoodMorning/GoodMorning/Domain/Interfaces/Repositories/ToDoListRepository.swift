//
//  ToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

protocol ToDoListRepository {

    func fetchToDoList() -> [TODOItem]
    func addToDoListItem(item: TODOItem) async throws
    func deleteToDoListItem(item: TODOItem) throws
    func updateToDoItem(item: TODOItem) throws

}
