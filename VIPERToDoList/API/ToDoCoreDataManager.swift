//
//  ToDoCoreDataManager.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import UIKit
import CoreData

protocol ToDoCoreDataManagerProtocol {
    func saveToDoList(_ toDoList: [ToDoEntity], completion: @escaping (Result<Void, Error>) -> Void)
    func fetchToDoList(completion: @escaping (Result<[ToDoEntity], Error>) -> Void)
    func updateToDo(_ toDo: ToDoEntity, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteToDo(_ toDoList: [ToDoEntity])
    func saveToDo(_ toDo: ToDoEntity, completion: @escaping (Result<Void, Error>) -> Void)
}

class ToDoCoreDataManager {
    static let shared = ToDoCoreDataManager()
    private let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoCD") 
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension ToDoCoreDataManager: ToDoCoreDataManagerProtocol {
    func fetchToDoList(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<ToDoCD> = ToDoCD.fetchRequest()
        
        context.perform {
            do {
                let fetchedTodos = try self.context.fetch(fetchRequest)
                let todos = fetchedTodos.map { toDoCD in
                    ToDoEntity(
                        id: toDoCD.id ?? UUID(),
                        title: toDoCD.title ?? "",
                        description: toDoCD.taskDescription ?? "",
                        completed: toDoCD.completed,
                        createdAt: toDoCD.createdAt ?? Date()
                    )
                }
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func updateToDo(_ toDo: ToDoEntity, completion: @escaping (Result<Void, any Error>) -> Void) {
        //TODO: реализовать
    }
    
    func deleteToDo(_ toDoList: [ToDoEntity]) {
        //TODO: реализовать
    }
    
    func saveToDoList(_ todos: [ToDoEntity], completion: @escaping (Result<Void, Error>) -> Void) {
        context.perform {
            do {
                // Очистка старых данных, если необходимо
                let fetchRequest: NSFetchRequest<ToDoCD> = ToDoCD.fetchRequest()
                let existingTodos = try self.context.fetch(fetchRequest)
                for todo in existingTodos {
                    self.context.delete(todo)
                }
                
                // Сохранение новых задач в Core Data
                for todo in todos {
                    let newTodo = ToDoCD(context: self.context)
                    newTodo.id = UUID()
                    newTodo.title = todo.title
                    newTodo.taskDescription = todo.description
                    newTodo.createdAt = todo.createdAt
                    newTodo.completed = todo.completed
                }
                
                try self.context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveToDo(_ toDo: ToDoEntity, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Saving new todo: \(toDo)")  // Печать для отладки
        DispatchQueue.main.async {
            do {
                let newToDo = ToDoCD(context: self.context)
                newToDo.id = toDo.id
                newToDo.title = toDo.title
                newToDo.taskDescription = toDo.description
                newToDo.completed = toDo.completed
                newToDo.createdAt = toDo.createdAt

                try self.context.save()

                print("New todo saved: \(newToDo)") // Печать для отладки

                completion(.success(()))
            } catch {
                print("Error saving new todo: \(error)") // Печать ошибки
                completion(.failure(error))
            }
        }
    }
}

//MARK: Для отладки
extension ToDoCoreDataManager {
    func clearCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ToDoCD.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear Core Data: \(error.localizedDescription)")
        }
    }
}
