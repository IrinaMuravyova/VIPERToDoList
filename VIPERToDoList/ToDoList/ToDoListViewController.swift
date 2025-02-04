//
//  ViewController.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    
}

class ToDoListViewController: UIViewController {
    
    var presenter: ToDoListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ToDoListViewController: ToDoListViewProtocol {
    
}
