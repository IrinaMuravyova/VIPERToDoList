//
//  NewToDoRouter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import UIKit

protocol TodoEditRouterProtocol: AnyObject {
    func closeModule()
    func openEditToDoScreen(todo: ToDoEntity)
}

class TodoEditRouter {
    weak var presenter: NewToDoPresenterProtocol?
}

extension TodoEditRouter: TodoEditRouterProtocol {
    func closeModule() {
        if let viewController = presenter?.view as? UIViewController {
            if let navigationController = viewController.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                viewController.dismiss(animated: true)
            }
        }
    }
    
    func openEditToDoScreen(todo: ToDoEntity) {
        presenter?.showToDoDetails(todo: todo)
    }
}
