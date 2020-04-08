//
//  Column.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Column {
    
    let identifier: Int
    var name: String
    private(set) var cards: [Card]
    var numberOfCards: Int {
        return cards.count
    }
    
    mutating func appendCard(_ card: Card) {
        cards.append(card)
    }
}
