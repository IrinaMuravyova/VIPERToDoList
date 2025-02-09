//
//  EditToDoRouter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 07.02.2025.
//

import UIKit

protocol ActionsToDoRouterProtocol: AnyObject {
    func openEditToDoScreen(todo: ToDoEntity)
    func updateToDoListWithUpdatedTodos(_ todos: [ToDoEntity])
    func openEditToDoScreenForEdit(todo: ToDoEntity)
}

class ActionsRouter {
    weak var presenter: EditToDoPresenterProtocol?
    weak var viewController: UIViewController?
    var toDoListRouter: ToDoListRouterProtocol?
    var newToDoRouter: NewToDoRouterProtocol?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ActionsRouter: ActionsToDoRouterProtocol {
    func openEditToDoScreen(todo: ToDoEntity) {
        let editToDoViewController = ActionsToDoConfigure.configure(delegate: self, todo: todo)
        editToDoViewController.modalPresentationStyle = .fullScreen
        viewController?.present(editToDoViewController, animated: true) // в ТЗ не сказано какая должна быть анимация
    }
    
    func updateToDoListWithUpdatedTodos(_ todos: [ToDoEntity]) {
        toDoListRouter?.updateToDoListWithUpdatedTodos(todos)
    }
    
    func openEditToDoScreenForEdit(todo: ToDoEntity) {
        newToDoRouter?.openEditToDoScreen(todo: todo)
    }
}

extension ActionsRouter: EditToDoPresenterDelegate {
    func didUpdateToDo(_ todo: ToDoEntity) {
        print("EditToDoRouter: didUpdateToDo вызван с задачей \(todo.title)")
    }
}
