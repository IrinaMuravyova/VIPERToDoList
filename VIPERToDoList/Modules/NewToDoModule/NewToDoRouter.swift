//
//  NewToDoRouter.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import UIKit

protocol NewToDoRouterProtocol: AnyObject {
    func closeModule()
}

class NewToDoRouter {
    weak var viewController: UIViewController?
}

extension NewToDoRouter: NewToDoRouterProtocol {
    func closeModule() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
