//
//  Activity.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct Activity: Decodable {
    let identifier: Int
    let userId: String
    let profileURL: String
    let action: String
    let title: String
    let fromColumn: String
    let toColumn: String
    let actionTime: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case profileURL = "profileUrl"
        case userId, action, title, fromColumn, toColumn, actionTime
    }
}
