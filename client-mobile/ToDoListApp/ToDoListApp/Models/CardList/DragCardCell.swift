//
//  DragCardCell.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

struct DragCardCell {
    let tableView: UITableView
    let columnId: Int
    let cardListViewModel: CardListViewModel
    let card: Card
    let row: Int
}
