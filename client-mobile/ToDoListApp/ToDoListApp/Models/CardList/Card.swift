//
//  Card.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Card: Codable {
    
    let identifier: Int
    let userID: String
    let title: String
    let contents: String
    let device: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case userID = "userId"
        case title, contents, device
    }
}
