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
        
        requestColumnsData { (columns) in
            DispatchQueue.main.async {
                self.configureColumns(columns)
            }
        }
    }
    
    private func requestColumnsData(completion: @escaping ([Column]) -> Void) {
        MockNetworkManager.shared.requestColumns { (columns, error) in
            if error != nil {
                // alert
                return
            }
            guard let columns = columns else { return }
            completion(columns)
        }
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

