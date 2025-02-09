//
//  NewToDoPresenter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import Foundation

protocol TodoEditPresenterProtocol: AnyObject {
    var view: NewToDoViewProtocol? { get set }
    var delegate: TodoEditPresenterDelegate? { get set }
    func saveToDo(title: String, description: String?, completed: Bool, createdAt:Date)
    func didSaveToDo(_ toDo: ToDoEntity)
    func didFailToSaveToDo(error: any Error)
    func showToDoDetails(todo: ToDoEntity)
}

class TodoEditPresenter {
    weak var view: NewToDoViewProtocol?
    weak var delegate: TodoEditPresenterDelegate?
    var interactor: TodoEditInteractorProtocol
    var router: TodoEditRouterProtocol
    
    init(interactor: TodoEditInteractorProtocol, router: TodoEditRouterProtocol, delegate: TodoEditPresenterDelegate?) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

extension TodoEditPresenter: TodoEditPresenterProtocol {
    func saveToDo(title: String, description: String?, completed: Bool, createdAt: Date) {
        let id = UUID()
        interactor.saveToDo(id: id, title: title, description: description, completed: completed, createdAt: createdAt)
    }
    
    func didSaveToDo(_ toDo: ToDoEntity) {
        view?.todoAddSuccessed()
        delegate?.didAddNewToDo()
        router.closeModule()
    }
    
    func didFailToSaveToDo(error: any Error) {
        view?.showError(error.localizedDescription)
    }
    
    func showToDoDetails(todo: ToDoEntity) {
        let editToDoRouter = ActionsRouter(viewController: view as! ActionsViewController)
        editToDoRouter.openEditToDoScreen(todo: todo)
    }
}
