//
//  ColumnViewModel+DragDelegate.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

extension CardListViewModel: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        let card = self.card(at: indexPath.row)
        dragItem.localObject = DragCardCell(tableView: tableView, columnId: columnId, cardListViewModel: self, card: card, row: indexPath.row)
        return [dragItem]
    }
}

