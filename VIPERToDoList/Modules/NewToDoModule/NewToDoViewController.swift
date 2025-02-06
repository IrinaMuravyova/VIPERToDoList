//
//  NewToDoViewController.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 06.02.2025.
//

import UIKit

protocol NewToDoViewProtocol: AnyObject {
    func showError(_ message: String)
    func dismiss()
    func showSuccessMessage()
    func showErrorMessage(_ message: String)
}

class NewToDoViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTF: UITextField!
    @IBOutlet weak var todoDateTF: UITextField!
    @IBOutlet weak var todoDescriptionTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var presenter: NewToDoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        guard let title = todoTitleTF.text, !title.isEmpty else {
            showError("Введите заголовок задачи")
            return
        }
        let date = formatDate(input:todoDateTF.text ?? "") // при создании новой задачи дату по умолчанию ставлю сегодня - в ТЗ не уточнено, на вопросы по почте не ответили
        presenter?.saveToDo(title: title, description: todoDescriptionTF.text, completed: false, createdAt: date)
    }
    
    func formatDate(input: String) -> Date {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: input) {
            return date
        }
        
        return Date()
    }
}

extension NewToDoViewController: NewToDoViewProtocol {
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
        
    func dismiss() {
        dismiss(animated: true)
    }
    
    func showSuccessMessage() {
        let alert = UIAlertController(title: "Успех", message: "Задача сохранена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}
