//
//  ColumnViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/09.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Key
    func updateNotify(changed: @escaping (Key) -> Void)
}

class ColumnViewModel: ViewModelBinding {
    
    typealias Key = Column?
    private var column: Key = nil { didSet { changeHandler(column) } }
    private var changeHandler: (Key) -> Void
    var numberOfCards: Int {
        return column?.numberOfCards ?? 0
    }
    
    init(with column: Column? = nil, changed handler: @escaping (Key) -> Void = { _ in } ) {
        self.changeHandler = handler
        self.column = column
        changeHandler(column)
    }
    
    func updateColumn(_ column: Column) {
        self.column = column
    }
    
    func updateNotify(changed: @escaping (Column?) -> Void) {
        self.changeHandler = changed
    }
    
    func addCard(_ card: Card) {
        column?.appendCard(card)
    }
}
