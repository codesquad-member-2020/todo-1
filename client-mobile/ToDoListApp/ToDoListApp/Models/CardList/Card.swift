//
//  Card.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Card {
    
    private(set) var identifier: Int
    private(set) var title: String
    private(set) var contents: String
    private(set) var device: String
    private(set) var index: Int
    
    init(viewModel: CardViewModel) {
        self.identifier = 0
        self.title = viewModel.title
        self.contents = viewModel.contents
        self.device = viewModel.device
        self.index = viewModel.index
    }
}
