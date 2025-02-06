//
//  NewToDoModuleConfigure.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import UIKit

class NewToDoModuleConfigure {
    static func configure(output: NewToDoInteractorOutputProtocol?) -> UIViewController {
        let view = NewToDoViewController()
        let interactor = NewToDoInteractor(coreDataManager: ToDoCoreDataManager.shared)
        let router = NewToDoRouter()
        let presenter = NewToDoPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
