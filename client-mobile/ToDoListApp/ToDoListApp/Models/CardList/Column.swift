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
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "columnName"
        case cards, section
    }
    
    mutating func insertCard(_ card: Card, at index: Int) {
        cards.insert(card, at: index)
    }
}
