//
//  NewToDoModuleConfigure.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import UIKit

class TodoEditModuleConfigure {
    static func configure(output: NewToDoInteractorOutputProtocol?, delegate: NewToDoPresenterDelegate?) -> NewToDoViewController {

        let interactor = NewToDoInteractor(coreDataManager: ToDoCoreDataManager.shared)
        let router = NewToDoRouter()
        let presenter = NewToDoPresenter(interactor: interactor, router: router, delegate: delegate)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewToDoViewController") as? NewToDoViewController else {
            fatalError("Не удалось создать NewToDoViewController из Storyboard")
        }
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
}
