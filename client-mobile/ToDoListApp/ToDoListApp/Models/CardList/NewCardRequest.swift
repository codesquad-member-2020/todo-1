//
//  NewCardRequest.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/15.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct NewCardRequest: Encodable {
    
    let userId: String
    let title: String
    let contents: String
    let device: String = "iOS"
}
