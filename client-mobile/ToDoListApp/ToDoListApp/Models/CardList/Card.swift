//
//  Card.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Card: Codable {
    
    private(set) var identifier: Int?
    private(set) var title: String
    private(set) var contents: String
    private(set) var device: String
    private(set) var row: Int
    
    init(identifier: Int? = nil, title: String, contents: String, device: String, index: Int) {
        self.identifier = identifier
        self.title = title
        self.contents = contents
        self.device = device
        self.row = index
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title, contents, device, row
    }
}
