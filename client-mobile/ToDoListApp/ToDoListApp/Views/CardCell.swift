//
//  CardCell.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    static let identifier = "CardCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.layer.shadowRadius = 0.8
        cellBackgroundView.layer.shadowOpacity = 0.3
        cellBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        cellBackgroundView.layer.shadowOffset = .init(width: 1, height: 1.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
