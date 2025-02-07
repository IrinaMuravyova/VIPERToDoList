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
    private let userDefaults: UserDefaults
    
    private let isFirstLaunchKey = "isFirstLaunch"
    
    init(networkManager: ToDoNetworkManagerProtocol, dataManager: ToDoCoreDataManagerProtocol, userDefaults: UserDefaults = .standard) {
        self.networkManager = networkManager
        self.dataManager = dataManager
        self.userDefaults = userDefaults
    }
    
    func getToDos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
//            UserDefaults.standard.set(true, forKey: "isFirstLaunch") // для отладки
            let isFirstLaunch = self.userDefaults.bool(forKey: self.isFirstLaunchKey)
    
            if isFirstLaunch {
                self.networkManager.fetchToDos { result in
                    switch result {
                    case .success(let todos):
                        self.dataManager.saveToDoList(todos) {_ in
                            DispatchQueue.main.async {
                                completion(.success(todos))
                                self.userDefaults.set(false, forKey: self.isFirstLaunchKey)
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            } else {
                self.dataManager.fetchToDoList { localTodosResult in
                    switch localTodosResult {
                    case .success(let localTodos):
                        if !localTodos.isEmpty {
                            DispatchQueue.main.async {
                                completion(.success(localTodos))
                            }
                            return
                        }
                    case .failure:
                        break // Если произошла ошибка, пробуем загрузить из сети
                    }
                }
            }
        }
    }
}
