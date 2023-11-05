//
//  ToDoListRepository.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/03.
//

protocol ToDoListRepository {

    func fetchToDoList() -> [ToDoItem]
    func addToDoItem(item: ToDoItem) async throws
    func deleteToDoItem(_ id: String) throws
    func updateToDoItem(
        _ id: String,
        isChecked: Bool,
        routine: String,
        icon: String?,
        priority: Priority
    ) throws

}
