//
//  ToDoCoreDataManager.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoCoreDataManagerProtocol {
    func saveToDoList(_ toDoList: [ToDoEntity])
    func fetchToDoList() -> [ToDoEntity]
    func updateToDo(_ toDoList: [ToDoEntity])
    func deleteToDo(_ toDoList: [ToDoEntity])
}

class ToDoCoreDataManager {
    
}

extension ToDoCoreDataManager: ToDoCoreDataManagerProtocol {
    func saveToDoList(_ toDoList: [ToDoEntity]) {
        //TODO: реализовать
    }
    
    func fetchToDoList() -> [ToDoEntity] {
        //TODO: реализовать
        return []
    }
    
    func updateToDo(_ toDoList: [ToDoEntity]) {
        //TODO: реализовать
    }
    
    func deleteToDo(_ toDoList: [ToDoEntity]) {
        //TODO: реализовать
    }
    
    
}
