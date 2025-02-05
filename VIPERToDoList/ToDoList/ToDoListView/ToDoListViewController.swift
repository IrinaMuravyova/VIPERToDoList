//
//  ToDoListViewController.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 04.02.2025.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    func showToDoList(_ toDoList: [ToDoEntity])
    func displayTodosCount(_ todosCountString: String)
}

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todosCountToolBarItem: UIBarButtonItem!
    
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
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11)
        ]
        todosCountToolBarItem.setTitleTextAttributes(textAttributes, for: .normal)
    }
}

extension ToDoListViewController: ToDoListViewProtocol {
    func showToDoList(_ toDoList: [ToDoEntity]) {
        self.todos = toDoList
        tableView.reloadData()
    }
    
    func displayTodosCount(_ todosCountString: String) {
        todosCountToolBarItem.title = todosCountString
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
   
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        
        return cell
    }
}
