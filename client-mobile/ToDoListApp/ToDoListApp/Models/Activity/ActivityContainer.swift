//
//  ActivityContainer.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct ActivityContainer: Decodable {
    let status: Int
    let activities: [Activity]
}
