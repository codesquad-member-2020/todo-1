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
    
    private var todoCardListViewController: CardListViewController!
    private var inProgressCardListViewController: CardListViewController!
    private var doneCardListViewController: CardListViewController!
    
    var todoTableView: UITableView!
    var inProgressTableView: UITableView!
    var doneTableView: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let toDoCardListDataSource = ToDoCardListDataSource()
    let inProgressCardListDataSource = InProgressCardListDataSource()
    let doneCardListDataSource = DoneCardListDataSource()
    
    let toDoCardListDelegate = ToDoCardListDelegate()
    let inProgressCardListDelegate = InProgressCardListDelegate()
    let doneCardListDelegate = DoneCardListDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoCardListViewController = storyboard?.instantiateViewController(identifier: cardListViewControllerIdentifier)
        inProgressCardListViewController = storyboard?.instantiateViewController(identifier: cardListViewControllerIdentifier)
        doneCardListViewController = storyboard?.instantiateViewController(identifier: cardListViewControllerIdentifier)
        
        [todoCardListViewController, inProgressCardListViewController, doneCardListViewController].forEach {
            self.addChild($0!)
            self.stackView.addArrangedSubview($0!.view)
        }
    }
    
    private func configureCardList() {
        configureCardListDatasource()
        configureCardListDelegate()
    }
    
    private func configureCardListDatasource() {
        todoTableView.dataSource = toDoCardListDataSource
        inProgressTableView.dataSource = inProgressCardListDataSource
        doneTableView.dataSource = doneCardListDataSource
    }
    
    private func configureCardListDelegate() {
        todoTableView.delegate = toDoCardListDelegate
        inProgressTableView.delegate = inProgressCardListDelegate
        doneTableView.delegate = doneCardListDelegate
    }
}

