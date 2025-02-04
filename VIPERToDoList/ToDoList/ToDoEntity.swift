//
//  ToDoListEntity.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

struct ToDoEntity {
    let id: Int
    let title: String
    let description: String?
    let completed: Bool
    let createdAt: Date
    let userId: Int
}
