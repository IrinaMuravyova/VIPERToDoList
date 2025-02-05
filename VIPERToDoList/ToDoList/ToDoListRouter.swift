//
//  ToDoListRouter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListRouterProtocol: AnyObject {
    func navigateToDetail(for toDo: ToDoEntity)
}

class ToDoListRouter {
    weak var presenter: ToDoListPresenterProtocol?
}

extension ToDoListRouter: ToDoListRouterProtocol {
    func navigateToDetail(for toDo: ToDoEntity) {
        //TODO: реализовать
    }
}
