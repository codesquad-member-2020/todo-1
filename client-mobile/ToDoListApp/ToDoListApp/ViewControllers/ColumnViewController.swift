//
//  TempVCViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ColumnViewController: UIViewController, NewCardDelegation {
    
    static let identifier = "Column"
    
    @IBOutlet weak var columnView: ColumnView!
    @IBOutlet weak var badgeView: BadgeView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let cardListDataSource = CardListDataSource()
    
    var columnViewModel: ColumnViewModel? { didSet { configureViewModelHandler() } }
    private var cardListViewModel = CardListViewModel()
    
    private var columnId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColumnView()
        configureTableView()
    }
    
    func setColumnId(_ id: Int) {
        self.columnId = id
    }
    
    func updateColumn(_ column: Column) {
        columnViewModel?.updateColumn(column)
    }
    
    private func updateColumn(_ column: Column?) {
        guard let column = column else { return }
        columnView.updateName(column.name)
        columnView.updateBadge(column.cards)
        cardListDataSource.updateCardList(column.cards)
        tableView.reloadData()
    }
    
    @IBAction func toAddNewCardButtonTapped(_ sender: Any) {
        presentCardViewController()
    }
    
    private func presentCardViewController(card: Card? = nil) {
        guard let newCardViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? NewCardViewController else { return }
        present(newCardViewController, animated: true, completion: {
            newCardViewController.updateCard(card)
            newCardViewController.newCardDelegate = self
            newCardViewController.setColumnId(self.columnId)
        })
    }
    
    func addNewCard(_ card: Card) {
        tableView.beginUpdates()
        cardListViewModel.insertCard(card, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
    
    func removeCard(at index: Int) {
        tableView.beginUpdates()
        cardListViewModel.removeCard(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        tableView.endUpdates()
    }
}

extension ColumnViewController {
    
    // MARK:- Configuration
    private func configureViewModelHandler() {
        columnViewModel?.updateNotify(changed: { (column) in
            self.updateColumn(column)
            self.cardListViewModel.updateCardList(column?.cards)
        })
        cardListViewModel.updateNotify { (cardList) in
            self.columnView.updateBadge(cardList)
            self.cardListDataSource.updateCardList(cardList)
        }
        cardListViewModel.didTapEdit = { card in
            self.presentCardViewController(card: card)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = cardListDataSource
        tableView.delegate = cardListViewModel
    }
    
    private func configureColumnView() {
        columnView.badgeView = badgeView
        columnView.badgeLabel = badgeLabel
        columnView.nameLabel = columnNameLabel
        columnView.addCardButton = addCardButton
    }
}
