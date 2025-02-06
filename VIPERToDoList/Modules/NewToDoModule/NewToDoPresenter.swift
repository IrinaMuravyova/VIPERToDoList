//
//  NewToDoPresenter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import Foundation

protocol NewToDoPresenterProtocol: AnyObject {
    func saveToDo(title: String, description: String?, completed: Bool, createdAt:Date)
}

class NewToDoPresenter {
    weak var view: NewToDoViewProtocol?
    var interactor: NewToDoInteractorProtocol?
    var router: NewToDoRouterProtocol?
    
    init(view: NewToDoViewProtocol, interactor: NewToDoInteractorProtocol, router: NewToDoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewToDoPresenter: NewToDoPresenterProtocol {
    func saveToDo(title: String, description: String?, completed: Bool, createdAt: Date) {
        let newTodo = ToDoEntity(id: UUID(), title: title, description: description, completed: completed, createdAt: createdAt) //TODO: Как определять пользователя и id задачи в ТЗ не сказано
        interactor?.saveToDo(newTodo)
        view?.dismiss()
    }
}

extension NewToDoPresenter: NewToDoInteractorOutputProtocol {
    func didSaveToDo(_ toDo: ToDoEntity) {
        view?.showSuccessMessage()
        router?.closeModule()
    }
    
    func didFailToSaveToDo(error: any Error) {
        view?.showErrorMessage(error.localizedDescription)
    }
}
