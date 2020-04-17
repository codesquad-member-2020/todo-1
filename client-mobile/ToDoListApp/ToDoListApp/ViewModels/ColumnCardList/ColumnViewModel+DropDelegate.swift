//
//  ColumnViewModel+DropDelegate.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

extension CardListViewModel: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.items.forEach { item in
            
            guard let dragCardCell = item.dragItem.localObject as? DragCardCell else { return }
            let dragTableView = dragCardCell.tableView
            let dragCardListViewModel = dragCardCell.cardListViewModel
            let dragRow = dragCardCell.row
            let dragColumnId = dragCardCell.columnId
            let draggedCard = dragCardCell.card
            let dragCardId = draggedCard.identifier
            
            let cardMoveRequest = CardMoveRequest(toColumn: columnId, toRow: destinationIndexPath.row)
            NetworkManager.shared.requestDataWithBody(method: .post, body: cardMoveRequest, columnId: dragColumnId, cardId: dragCardId) { (result: Result<CardContainer, RequestError>) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        dragCardListViewModel.removeCard(at: dragRow)
                        dragTableView.beginUpdates()
                        dragTableView.deleteRows(at: [IndexPath(row: dragRow, section: 0)], with: .fade)
                        dragTableView.endUpdates()
                        
                        self.insertCard(draggedCard, at: destinationIndexPath.row)
                        tableView.beginUpdates()
                        tableView.insertRows(at: [IndexPath(row: destinationIndexPath.row, section: 0)], with: .fade)
                        tableView.endUpdates()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
