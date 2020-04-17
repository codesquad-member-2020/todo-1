//
//  CardListViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/13.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardListViewModel: NSObject, ViewModelBinding {
    
    typealias Key = [Card]
    
    private(set) var columnId: Int!
    
    private var cardList: Key = [] { didSet { changeHandler(cardList) } }
    private var changeHandler: (Key) -> Void
    var didTapEdit: ((Card, Int) -> Void)?
    var didTapRemove: ((Card, Int) -> Void)?
    
    init(with cardList: [Card] = [], changed handler: @escaping (Key) -> Void = { _ in } ) {
        self.changeHandler = handler
        self.cardList = cardList
        changeHandler(cardList)
    }
    
    func updateCardList(_ cardList: [Card]?) {
        self.cardList = cardList ?? []
    }
    
    func updateNotify(changed: @escaping ([Card]) -> Void) {
        self.changeHandler = changed
    }
    
    func configureColumnId(_ columnId: Int) {
        self.columnId = columnId
    }
    
    func card(at row: Int) -> Card {
        return cardList[row]
    }
    
    func insertCard(_ card: Card, at row: Int) {
        cardList.insert(card, at: row)
    }
    
    func removeCard(at row: Int) {
        cardList.remove(at: row)
    }
    
    func editCard(at row: Int, with card: Card) {
        cardList[row] = card
    }
}

// MARK:- UITableViewDelegate

extension CardListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            let card = self.cardList[indexPath.item]
            self.didTapRemove?(card, indexPath.item)
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            let editAction = UIAction(title: "Edit", image: UIImage(named: "card-edit")) { _ in
                let currentCard = self.cardList[indexPath.item]
                self.didTapEdit?(currentCard, indexPath.item)
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(named: "card-remove"), attributes: .destructive) { _ in
                let card = self.cardList[indexPath.item]
                self.didTapRemove?(card, indexPath.item)
            }
            return UIMenu(title: "", children: [editAction, deleteAction])
        }
    }
}
