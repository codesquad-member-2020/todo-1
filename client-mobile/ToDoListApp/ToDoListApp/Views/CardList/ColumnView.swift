//
//  ColumnView.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ColumnView: UIView {

    var bedgeView: BedgeView!
    var bedgeLabel: UILabel! { didSet { bedgeView.bedgeLabel = bedgeLabel } }
    var nameLabel: UILabel!
    var addCardButton: UIButton!
    
    func updateName(_ name: String) {
        nameLabel.text = name
    }
    
    func updateBedge(_ cards: [Card]) {
        bedgeView.updateBedge(bedgeCount: cards.count)
    }
}
