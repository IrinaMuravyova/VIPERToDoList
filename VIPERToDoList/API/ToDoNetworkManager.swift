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
    func fetchToDos(completion: @escaping (Result<[ToDoEntity], any Error>) -> Void) {
        let urlString = "https://dummyjson.com/todos/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
                        id: todo.id,
                        title: todo.todo,
                        description: nil,  // В API нет описания
                        completed: todo.completed,
                        createdAt: Date(),  // Использую текущую дату
                        userId: todo.userId
                    )
                }
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
}
