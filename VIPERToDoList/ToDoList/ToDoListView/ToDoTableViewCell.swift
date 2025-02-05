//
//  ToDoTableViewCell.swift
//  VIPERToDoList
//
//  Created by Irina Muravyeva on 05.02.2025.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var completedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with todo: ToDoEntity) {
        let dateString = formatDate(input: todo.createdAt)
        dateLabel.attributedText = NSAttributedString(
            string: dateString,
            attributes: [.foregroundColor: UIColor.gray]
            )
        
        if todo.completed {
            
            completedImage.image = UIImage(systemName: "checkmark.circle")
            completedImage.tintColor = UIColor(.yellow)
            
            let completedAttributedTitleString = NSMutableAttributedString(
                string: todo.title,
                attributes: [
                    .foregroundColor: UIColor.gray,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.gray
                ]
            )
            titleLabel.attributedText = completedAttributedTitleString
            
            descriptionLabel.attributedText = NSAttributedString(
                string: todo.description ?? "",
                attributes: [.foregroundColor: UIColor.gray]
            )
        } else {
            completedImage.image = UIImage(systemName: "circle")
            completedImage.tintColor = UIColor(.gray)
            titleLabel.text = todo.title
            descriptionLabel.text = todo.description
        }
    }
    
    func formatDate(input: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yy"
        return outputFormatter.string(from: input)
    }
}
