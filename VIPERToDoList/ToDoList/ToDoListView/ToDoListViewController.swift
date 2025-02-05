//
//  ToDoListViewController.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    func showToDoList(_ toDoList: [ToDoEntity])
}

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: ToDoListPresenterProtocol?
    private var todos: [ToDoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if presenter == nil {
            print("ViewController: presenter is nil!")
        } else {
            print("ViewController: presenter exists")
            presenter?.viewDidLoad()
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "task")
    }
}

extension ToDoListViewController: ToDoListViewProtocol {
    func showToDoList(_ toDoList: [ToDoEntity]) {
        self.todos = toDoList
        tableView.reloadData()
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.completed ? .checkmark : .none
        return cell
    }
}
