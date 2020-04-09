//
//  Column.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Column: Codable {
    
    let identifier: Int
    private(set) var name: String
    private(set) var cards: [Card]
    private(set) var section: Int
    var numberOfCards: Int {
        return cards.count
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "columnName"
        case cards, section
    }
    
    mutating func appendCard(_ card: Card) {
        cards.append(card)
    }
    
    func toViewModel() -> ColumnViewModel {
        return ColumnViewModel(with: self)
    }
}
