//
//  ToDoListModuleConfigure.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import UIKit

class ToDoListModuleConfigure {
    static func configure() -> ToDoListViewController {
        let interactor = ToDoListInteractor()
        let router = ToDoListRouter()
        let networkManager = ToDoNetworkManager()
        let dataManager = ToDoCoreDataManager()
        let repository = ToDoListRepository(networkManager: networkManager, dataManager: dataManager)
        let presenter = ToDoListPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ToDoListViewController") as? ToDoListViewController else {
            fatalError("Не удалось создать ToDoListViewController из Storyboard")
        }
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.repository = repository
        router.presenter = presenter
        
        return viewController
    }
}
