//
//  EditToDoInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 07.02.2025.
//

import Foundation

protocol EditToDoInteractorProtocol: AnyObject {
    func shareButtonDidPress()
    func deleteButtonDidPress(todo: ToDoEntity)
}

class ActionsInteractor {
    weak var presenter: EditToDoPresenterProtocol?
    var repository: ToDoListRepositoryProtocol?
    private let coreDataManager: ToDoCoreDataManager
    
    init(coreDataManager: ToDoCoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension ActionsInteractor: EditToDoInteractorProtocol {

    func shareButtonDidPress() {
        //TODO: Реализовать код
    }

    func deleteButtonDidPress(todo: ToDoEntity) {
        repository?.deleteToDo(id: todo.id) { [weak self] result in
            switch result {
            case .success:
                self?.repository?.getToDos { result in
                    switch result {
                    case .success(let todos):
                        self?.presenter?.todoDeleted(updatedTodos: todos)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
