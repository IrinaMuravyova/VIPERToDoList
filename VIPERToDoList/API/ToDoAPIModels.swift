//
//  ToDoAPIModels.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

struct ToDoAPIResponse: Decodable {
    let todos: [ToDoItemAPI]
}

struct ToDoItemAPI: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
