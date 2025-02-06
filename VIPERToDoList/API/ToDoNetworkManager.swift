//
//  ToDoNetworkManager.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoNetworkManagerProtocol {
    func fetchToDos(completion: @escaping (Result<[ToDoEntity], Error>) -> Void)
}

class ToDoNetworkManager: ToDoNetworkManagerProtocol {
    static let shared = ToDoNetworkManager()
    
    func fetchToDos(completion: @escaping (Result<[ToDoEntity], any Error>) -> Void) {
        let urlString = "https://dummyjson.com/todos/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ToDoAPIResponse.self, from: data)
                let todos = decodedResponse.todos.map { todo in
                    ToDoEntity(
                        id: self?.intToUUID(todo.id) ?? UUID(),
                        title: todo.todo,
                        description: nil,  // В API нет описания
                        completed: todo.completed,
                        createdAt: Date() // Использую текущую дату
                    )
                }
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func intToUUID(_ int: Int) -> UUID {
        let uuidString = String(int)
        let uuid = UUID(uuidString: uuidString) ?? UUID()
        return uuid
    }
}
