//
//  EditToDoPresenter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 07.02.2025.
//

import Foundation

protocol EditToDoPresenterProtocol: AnyObject, EditToDoPresenterDelegate {
    var view: EditToDoViewProtocol? { get set }
    var delegate: EditToDoPresenterDelegate? { get set }
    var todo: ToDoEntity? { get }
    func viewDidLoaded()
    func editButtonDidPress(todo: ToDoEntity)
//    func shareButtonDidPress()
    func deleteButtonDidPress(todo: ToDoEntity)
    func todoDeleted(updatedTodos: [ToDoEntity])
}

class ActionsPresenter {
    weak var view: EditToDoViewProtocol?
    weak var delegate: EditToDoPresenterDelegate?
    var interactor: EditToDoInteractorProtocol
    var router: ActionsToDoRouterProtocol
    var todo: ToDoEntity?
    
    init(interactor: EditToDoInteractorProtocol, router: ActionsToDoRouterProtocol, delegate: EditToDoPresenterDelegate?, todo: ToDoEntity) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
        self.todo = todo
    }
}

extension ActionsPresenter: EditToDoPresenterProtocol {
    func viewDidLoaded() {
        guard let todo = todo else { return }
        view?.updateView(with: todo)
    }
    
    func editButtonDidPress(todo: ToDoEntity) {
        router.openEditToDoScreenForEdit(todo: todo)
    }

//    func shareButtonDidPress() {
//        interactor.shareButtonDidPress
//    }

    func deleteButtonDidPress(todo: ToDoEntity) {
        interactor.deleteButtonDidPress(todo: todo)
    }
    
    func todoDeleted(updatedTodos: [ToDoEntity]) {
        router.updateToDoListWithUpdatedTodos(updatedTodos)
    }
}

extension ActionsPresenter: EditToDoPresenterDelegate {
    func didUpdateToDo(_ todo: ToDoEntity) {
        delegate?.didUpdateToDo(todo)
    }
}
