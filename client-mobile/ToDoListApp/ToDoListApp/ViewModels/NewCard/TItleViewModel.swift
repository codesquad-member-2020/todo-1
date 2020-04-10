//
//  TItleViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/10.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

class TitleViewModel {
    
    private var title: String = "" { didSet { changedHandler(title) } }
    
    private var changedHandler: (String) -> Void
    
    init(changed handler: @escaping (String) -> Void = { _ in }) {
        self.changedHandler = handler
    }
    
    func updateNotify(changed: @escaping (String) -> Void) {
        self.changedHandler = changed
    }
    
    func update(with text: String) {
        self.title = text
    }
}
