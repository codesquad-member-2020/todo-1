//
//  CardMoveRequest.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct CardMoveRequest: Encodable {
    let toColumn: Int
    let toRow: Int
}
