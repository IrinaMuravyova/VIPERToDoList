//
//  NewToDoInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import Foundation

protocol TodoEditInteractorProtocol: AnyObject {
    func saveToDo(id: UUID, title: String, description: String?, completed: Bool, createdAt: Date)
}

protocol TodoEditInteractorOutputProtocol: AnyObject {
    func didSaveToDo(_ toDo: ToDoEntity)
    func didFailToSaveToDo(error: Error)
}

class TodoEditInteractor {
    weak var output: TodoEditInteractorOutputProtocol?
    weak var presenter: TodoEditPresenterProtocol?
    var repository: ToDoListRepositoryProtocol?
    private let coreDataManager: ToDoCoreDataManager
    
    init(coreDataManager: ToDoCoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}
 
extension TodoEditInteractor: TodoEditInteractorProtocol {
 
    func saveToDo(id: UUID, title: String, description: String?, completed: Bool, createdAt: Date) {
        let todoEntity = ToDoEntity(
                id: id,
                title: title,
                description: description ?? "",
                completed: completed,
                createdAt: createdAt
            )
        
        coreDataManager.saveToDo(todoEntity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.presenter?.didSaveToDo(todoEntity)
                    self?.output?.didSaveToDo(todoEntity)
                case .failure(let error):
                    self?.output?.didFailToSaveToDo(error: error)
                }
            }
        }
    }
}

extension TodoEditInteractor: TodoEditInteractorOutputProtocol {
    func didSaveToDo(_ toDo: ToDoEntity) {
        presenter?.didSaveToDo(toDo)
        output?.didSaveToDo(toDo)
    }
    
    func didFailToSaveToDo(error: any Error) {
        presenter?.didFailToSaveToDo(error: error)
    }
}
