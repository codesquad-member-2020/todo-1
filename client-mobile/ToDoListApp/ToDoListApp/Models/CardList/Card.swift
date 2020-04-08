//
//  Card.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Card {
    
    let identifier: Int
    var column: Column
    var title: String
    var contents: String
    var device: String
    var index: Int
    
    init(viewModel: NewCardViewModel) {
        self.identifier = 0
        self.column = Column(identifier: 0, name: "", cards: [])
        self.title = viewModel.title
        self.contents = viewModel.contents
        self.device = viewModel.device
        self.index = 0
    }
}
