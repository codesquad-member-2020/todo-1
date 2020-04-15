//
//  UserInfo.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/16.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    let userId: String
    let profileURL: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case profileURL = "profileUrl"
    }
}
