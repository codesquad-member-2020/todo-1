//
//  UserData.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/10.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct UserData: Codable {
    
    let status: Int
    let columns: [Column]
}
