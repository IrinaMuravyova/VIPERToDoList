//
//  ToDoListInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListInteractorProtocol: AnyObject {
    func loadToDoList()
    func search(in todos: [ToDoEntity], with query: String, completion: @escaping ([ToDoEntity]) -> Void)
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
    
    func search(in todos: [ToDoEntity], with query: String, completion: @escaping ([ToDoEntity]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard !query.isEmpty else {
                DispatchQueue.main.async {
                    completion(todos)
                }
                return
            }
            
            let filteredTodos = todos.filter { $0.title.lowercased().contains(query.lowercased())
                || (($0.description?.lowercased().contains(query.lowercased())) != nil)
                || self.formatDate($0.createdAt).contains(query.lowercased())
            }
            
            DispatchQueue.main.async {
                completion(filteredTodos)
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String { //TODO: повтор кода
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            return formatter.string(from: date)
        }
}
