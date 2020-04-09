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
    
    private var columns: [Column] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardList()
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
    
    private func configureCardList() {
        for column in columns {
            guard let cardListViewController = storyboard?.instantiateViewController(identifier: CardListViewController.identifier) as? CardListViewController else { return }
            self.addChild(cardListViewController)
            self.stackView.addArrangedSubview(cardListViewController.view)
            cardListViewController.columnViewModel = ColumnViewModel()
            cardListViewController.updateColumn(column)
        }
    }
}

