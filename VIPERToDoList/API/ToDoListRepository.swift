//
//  ToDoListRepository.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListRepositoryProtocol {
    func getToDos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void)
}

class ToDoListRepository: ToDoListRepositoryProtocol {
    private let networkManager: ToDoNetworkManagerProtocol
    private let dataManager: ToDoCoreDataManagerProtocol
    
    init(networkManager: ToDoNetworkManagerProtocol, dataManager: ToDoCoreDataManagerProtocol) {
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    func getToDos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let localTodos = self.dataManager.fetchToDoList()
            if !localTodos.isEmpty {
                completion(.success(localTodos))
                return
            }
            
            self.networkManager.fetchToDos { result in
                switch result {
                case .success(let todos):
                    self.dataManager.saveToDoList(todos)
                    completion(.success(todos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
