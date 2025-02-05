//
//  ToDoListInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListInteractorProtocol: AnyObject {
    func loadToDoList()
    func searchToDoList(query: String)
}

class ToDoListInteractor {
    weak var presenter: ToDoListPresenterProtocol?
    var repository: ToDoListRepositoryProtocol?
}

extension ToDoListInteractor: ToDoListInteractorProtocol {
    func loadToDoList() {
        DispatchQueue.global(qos: .background).async {
            self.repository?.getToDos { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let todos):
                        self.presenter?.didLoadToDoList(todos)
                        self.presenter?.todosCountString(todos.count)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func searchToDoList(query: String) {
        //TODO: реализовать
    }
}
