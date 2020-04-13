//
//  ColumnView.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/07.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ColumnView: UIView {

    var badgeView: BadgeView!
    var badgeLabel: UILabel! { didSet { badgeView.badgeLabel = badgeLabel } }
    var nameLabel: UILabel!
    var addCardButton: UIButton!
    
    func updateName(_ name: String) {
        nameLabel.text = name
    }
    
    func updateBadge(_ cards: [Card]) {
        badgeView.updateBadge(badgeCount: cards.count)
    }
}
