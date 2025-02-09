//
//  EditToDoConfigure.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 07.02.2025.
//

import UIKit

class ActionsConfigure {
    static func configure(delegate: EditToDoPresenterDelegate, todo: ToDoEntity) -> UIViewController {
        
        let interactor = EditToDoInteractor(coreDataManager: ToDoCoreDataManager.shared)
        
        let storyboard = UIStoryboard(name: "Edit", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "EditToDoViewController") as? EditToDoViewController else {
            fatalError("Не удалось создать EditToDoViewController из Storyboard")
        }
        
        let router = ActionsRouter(viewController: viewController)
        let presenter = EditToDoPresenter(interactor: interactor, router: router, delegate: delegate, todo: todo)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
}

