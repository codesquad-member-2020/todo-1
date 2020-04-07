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
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    
    var card: Card! {
        didSet {
            updateCardCell()
        }
    }
    
    private func updateCardCell() {
        titleLabel.text = card.title
        deviceLabel.text = "\(card.device)에서 작성되었음."
        if card.contents == "" {
            contentLabel.removeFromSuperview()
        } else {
            contentLabel.text = card.contents
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
