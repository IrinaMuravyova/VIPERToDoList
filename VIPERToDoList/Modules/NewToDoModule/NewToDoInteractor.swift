//
//  NewToDoInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import Foundation

protocol NewToDoInteractorProtocol: AnyObject {
    func saveToDo(_ toDo: ToDoEntity)
}

protocol NewToDoInteractorOutputProtocol: AnyObject {
    func didSaveToDo(_ toDo: ToDoEntity)
    func didFailToSaveToDo(error: Error)
}

class NewToDoInteractor {
    weak var output: NewToDoInteractorOutputProtocol?
    private let coreDataManager: ToDoCoreDataManager
    
    init(coreDataManager: ToDoCoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}
 
extension NewToDoInteractor: NewToDoInteractorProtocol {
 
    func saveToDo(_ toDo: ToDoEntity) {
        coreDataManager.saveToDo(toDo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.output?.didSaveToDo(toDo)
                case .failure(let error):
                    self?.output?.didFailToSaveToDo(error: error)
                }
            }
        }
    }   
}
