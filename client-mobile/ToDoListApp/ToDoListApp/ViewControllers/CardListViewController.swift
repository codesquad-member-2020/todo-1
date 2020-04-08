//
//  TempVCViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {

    var column: Column! { didSet { updateColumn() } }
    
    @IBOutlet weak var columnView: ColumnView!
    @IBOutlet weak var bedgeView: BedgeView!
    @IBOutlet weak var bedgeLabel: UILabel!
    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = CardListDataSource()
    let delegate = CardListDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColumnView()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    private func configureColumnView() {
        columnView.bedgeView = bedgeView
        columnView.bedgeLabel = bedgeLabel
        columnView.nameLabel = columnNameLabel
        columnView.addCardButton = addCardButton
    }
    
    private func updateColumn() {
        columnView.updateName(column.name)
        columnView.updateBedge(column.cards)
        dataSource.cards = column.cards
        tableView.reloadData()
    }
    
    @IBAction func addNewCardButtonTapped(_ sender: Any) {
        guard let newCardViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? NewCardViewController else { return }
        present(newCardViewController, animated: true, completion: {
            newCardViewController.column = self.column
        })
    }
}
