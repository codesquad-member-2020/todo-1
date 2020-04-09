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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.backgroundColor = .red
        inProgressTableView.backgroundColor = .green
        doneTableView.backgroundColor = .yellow
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

