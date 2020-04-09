//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureToDoList()
    }
    
    private func configureToDoList() {
        requestColumnsData { (columns) in
            DispatchQueue.main.async {
                self.configureColumns(columns)
            }
        }
    }
    
    private func requestColumnsData(completion: @escaping ([Column]) -> Void) {
        MockNetworkManager.shared.requestColumns { (columns, error) in
            if error != nil {
                self.showErrorAlert()
                return
            }
            guard let columns = columns else { return }
            completion(columns)
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Network Error", message: "Failed to load data", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { _ in
            self.configureToDoList()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func configureColumns(_ columns: [Column]) {
        for column in columns {
            guard let columnViewController = storyboard?.instantiateViewController(identifier: ColumnViewController.identifier) as? ColumnViewController else { return }
            self.addChild(columnViewController)
            self.stackView.addArrangedSubview(columnViewController.view)
            columnViewController.columnViewModel = ColumnViewModel()
            columnViewController.updateColumn(column)
        }
    }
}

