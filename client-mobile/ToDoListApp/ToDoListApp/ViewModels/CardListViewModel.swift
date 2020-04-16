//
//  CardListViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/13.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardListViewModel: NSObject, ViewModelBinding, UITableViewDelegate {
    
    typealias Key = [Card]
    
    private var cardList: Key = [] { didSet { changeHandler(cardList) } }
    private var changeHandler: (Key) -> Void
    
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
    
    func insertCard(_ card: Card, at index: Int) {
        cardList.insert(card, at: index)
    }
    
    func removeCard(at index: Int) {
        cardList.remove(at: index)
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            self.removeCard(at: indexPath.item)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
                let editAction = UIAction(title: "Edit", image: UIImage(named: "card-edit")) { _ in
    
                }

                let deleteAction = UIAction(title: "Delete", image: UIImage(named: "card-remove"), attributes: .destructive) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        tableView.beginUpdates()
                        self.removeCard(at: indexPath.item)
                        tableView.deleteRows(at: [indexPath], with: .left)
                        tableView.endUpdates()
                    }
                }
                return UIMenu(title: "", children: [editAction, deleteAction])
            }
        }
}
