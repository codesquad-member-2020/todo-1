//
//  TempVCViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ToDoCardListDataSource()
    let delegate = ToDoCardListDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    

}
