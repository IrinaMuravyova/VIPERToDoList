//
//  EditToDoViewController.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 07.02.2025.
//

import UIKit

protocol EditToDoViewProtocol: AnyObject {
    func updateView(with todo: ToDoEntity)
}

protocol EditToDoViewControllerDelegate: AnyObject {
    
}

class ActionsViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var todoView: UIView!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var textFieldsStack: UIStackView!
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var actionsTableView: UITableView!
    
    weak var delegate: EditToDoViewControllerDelegate?
    var presenter: EditToDoPresenterProtocol?
    var todo: ToDoEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let presenter = presenter else {
            fatalError("Presenter is nil! Проверьте передачу данных в EditToDoModule")
        }
        presenter.viewDidLoaded()
        setupUI()
        dimmingView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        dimmingView.addGestureRecognizer(tapGesture)
        
        actionsTableView.dataSource = self
        actionsTableView.delegate = self
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        dimmingView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        todoView.layer.cornerRadius = 12
        actionsTableView.layer.cornerRadius = 12
        actionsTableView.rowHeight = UITableView.automaticDimension
        actionsTableView.estimatedRowHeight = 44
    }
    
    func formatDate(input: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yy"
        return outputFormatter.string(from: input)
    }
    
    func handleButtonTap(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Редактировать нажато")
            guard let todo = todo else {
                return
            }
            presenter?.editButtonDidPress(todo: todo)
        case 1:
            print("Поделиться нажато")
//            presenter?.shareButtonDidPress()
        default:
            print("Удалить нажато")
            guard let todo = todo else {
                return
            }
            presenter?.deleteButtonDidPress(todo: todo)
        }
    }
}

extension ActionsViewController: EditToDoViewProtocol {
    func updateView(with todo: ToDoEntity) {
        
        titleTF.text = todo.title
        descriptionTF.text = todo.description
        dateTF.text = formatDate(input: todo.createdAt)
    }
}

extension ActionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath)
        
        guard let actionCell = cell as? ActionsTableViewCell else {
                fatalError("Failed to cast cell to ActionsTableViewCell")
            }
        actionCell.configure(with: indexPath)
        actionCell.buttonAction = { [weak self] in
                self?.handleButtonTap(at: indexPath)
        }
        
        return cell
    }
}
