//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    var todoTableView: UITableView!
    var inProgressTableView: UITableView!
    var doneTableView: UITableView!
    
    @IBOutlet weak var toDoBedgeView: ToDoBedgeView!
    @IBOutlet weak var toDoBadgeLabel: UILabel!
    
    let toDoCardListDataSource = ToDoCardListDataSource()
    let toDoCardListDelegate = ToDoCardListDelegate()
    
    let inProgressCardListDataSource = InProgressCardListDataSource()
    let inProgressCardListDelegate = InProgressCardListDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = toDoCardListDataSource
        todoTableView.delegate = toDoCardListDelegate
        
        toDoBedgeView.badgeLabel = toDoBadgeLabel
        
        inProgressTableView.delegate = inProgressCardListDelegate
        inProgressTableView.dataSource = inProgressCardListDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case CardListViewController.todoIdentifier:
            let cardListViewController = segue.destination as! CardListViewController
            todoTableView = cardListViewController.tableView
        case CardListViewController.inProgressIdentifier:
            let cardListViewController = segue.destination as! CardListViewController
            inProgressTableView = cardListViewController.tableView
        case CardListViewController.doneIdentifier:
            let cardListViewController = segue.destination as! CardListViewController
            doneTableView = cardListViewController.tableView
        default:
            break
        }
    }
}

