//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    private let cardListViewControllerIdentifier = "CardList"
    
    @IBOutlet weak var stackView: UIStackView!
    
    private var columns: [Column] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardList()
    }
    
    private func configureCardList() {
        columns = [Column(identifier: 1, name: "해야할 일", cards: []),
                   Column(identifier: 2, name: "하고있는 일", cards: []),
                   Column(identifier: 3, name: "완료한 일", cards: [])]
        
        for column in columns {
            guard let cardList = storyboard?.instantiateViewController(identifier: cardListViewControllerIdentifier) as? CardListViewController else { return }
            self.addChild(cardList)
            self.stackView.addArrangedSubview(cardList.view)
            cardList.column = column
        }
    }
}

