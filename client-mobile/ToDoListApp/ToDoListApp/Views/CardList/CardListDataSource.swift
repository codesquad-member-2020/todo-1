//
//  ToDoCardListDataSource.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardListDataSource: NSObject, UITableViewDataSource {
    
    private var cards: [Card] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        cell.card = cards[indexPath.item]
        return cell
    }
    
    func updateCardList(_ cardList: [Card]) {
        self.cards = cardList
    }
}
