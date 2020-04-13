//
//  CardListViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/13.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

class CardListViewModel: ViewModelBinding {
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
}
