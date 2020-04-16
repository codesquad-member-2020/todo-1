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
    
    private var userInfo: UserInfo!
    private var columnId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColumnView()
        configureTableView()
    }
    
    func configureUserInfo(_ userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    func configureColumnId(_ id: Int) {
        self.columnId = id
    }
    
    func configureColumnViewModel(with column: Column) {
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
    
    private func presentCardViewController(card: Card? = nil, at row: Int? = nil, isCardEditing: Bool = false) {
        guard let cardEditorViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? CardEditorViewController else { return }
        present(cardEditorViewController, animated: true, completion: {
            cardEditorViewController.updateCard(card)
            cardEditorViewController.newCardDelegate = self
            cardEditorViewController.configureColumnId(self.columnId)
            cardEditorViewController.configureUserInfo(self.userInfo)
            cardEditorViewController.configureRow(row)
            cardEditorViewController.configureIsCardEditing(isCardEditing)
        })
    }
    
    private func requestRemoveCard(_ card: Card, at row: Int) {
        NetworkManager.shared.requestRemoveCard(columnId: columnId, cardId: card.identifier) { (result) in
            switch result {
            case .success(_):
                self.removeCard(at: row)
            case .failure(_):
                break
            }
        }
    }
    
    func removeCard(at row: Int) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.cardListViewModel.removeCard(at: row)
            self.tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .left)
            self.tableView.endUpdates()
        }
    }
    
    // MARK:- NewCardDelegation
    
    func addNewCard(_ card: Card) {
        tableView.beginUpdates()
        cardListViewModel.insertCard(card, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
    
    func editCard(_ card: Card, at row: Int) {
        tableView.beginUpdates()
        cardListViewModel.editCard(at: row, with: card)
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
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
        cardListViewModel.didTapEdit = { card, row in
            self.presentCardViewController(card: card, at: row, isCardEditing: true)
        }
        cardListViewModel.didTapRemove = { card, row in
            self.requestRemoveCard(card, at: row)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = cardListDataSource
        tableView.delegate = cardListViewModel
        tableView.dragDelegate = cardListViewModel
        tableView.dragInteractionEnabled = true
    }
    
    private func configureColumnView() {
        columnView.badgeView = badgeView
        columnView.badgeLabel = badgeLabel
        columnView.nameLabel = columnNameLabel
        columnView.addCardButton = addCardButton
    }
}
