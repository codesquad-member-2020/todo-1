//
//  Column.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Column {
    
    private(set) var identifier: Int
    private(set) var name: String
    private(set) var cards: [Card]
    var numberOfCards: Int {
        return cards.count
    }
    
    init(identifier: Int, name: String, cards: [Card]) {
        self.identifier = identifier
        self.name = name
        self.cards = cards
    }
    
    mutating func appendCard(_ card: Card) {
        cards.append(card)
    }
    
    func toViewModel() -> ColumnViewModel {
        return ColumnViewModel(with: self)
    }
}
