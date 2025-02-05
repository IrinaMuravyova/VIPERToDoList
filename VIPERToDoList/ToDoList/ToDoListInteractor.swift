//
//  ToDoListInteractor.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListInteractorProtocol: AnyObject {
    func loadToDoList()
    func search(in todos: [ToDoEntity], with query: String) -> [ToDoEntity]
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
    
    func search(in todos: [ToDoEntity], with query: String) -> [ToDoEntity] {
        guard !query.isEmpty else { return todos }
        
        return todos.filter { $0.title.lowercased().contains(query.lowercased())
            || (($0.description?.lowercased().contains(query.lowercased())) != nil)
            || formatDate($0.createdAt).contains(query.lowercased())
        }
    }
    
    private func formatDate(_ date: Date) -> String { //TODO: повтор кода
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            return formatter.string(from: date)
        }
}
