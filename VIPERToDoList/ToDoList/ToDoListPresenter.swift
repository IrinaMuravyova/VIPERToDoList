//
//  ToDoListPresenter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import Foundation

protocol ToDoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didLoadToDoList(_ todos: [ToDoEntity])
    func didSearch(query: String)
    func todosCountString(_ todosCount: Int)
}

class ToDoListPresenter {
    private var allTodos: [ToDoEntity] = [] // Хранит переданный список задач
    weak var view: ToDoListViewProtocol?
    var router: ToDoListRouterProtocol
    var interactor: ToDoListInteractorProtocol
    
    init(interactor: ToDoListInteractorProtocol, router: ToDoListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ToDoListPresenter: ToDoListPresenterProtocol {

    func viewDidLoad() {
        interactor.loadToDoList()
    }
    
    // Сохранение списка задач при загрузке экрана
    func didLoadToDoList(_ toDoList: [ToDoEntity]) {
        self.allTodos = toDoList
        view?.displayTodos(allTodos)
    }
    
    func didSearch( query: String) {
        let filteredTodos = interactor.search(in: allTodos, with: query)
        view?.displayTodos(filteredTodos)
    }
    
    func todosCountString(_ todosCount: Int) {
        let todosCountString = pluralizeTask(count: todosCount)
        view?.displayTodosCount(todosCountString)
    }
    
    private func pluralizeTask(count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100

        let word: String
        if remainder10 == 1 && remainder100 != 11 {
            word = "задача"
        } else if (2...4).contains(remainder10) && !(12...14).contains(remainder100) {
            word = "задачи"
        } else {
            word = "задач"
        }

        return "\(count) \(word)"
    }
}
