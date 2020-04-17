//
//  ActivityCell.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    static let identifier = "Activity"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let profileImageHeight: CGFloat = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureProfileImageView()
    }
    
    func updateCell(with activity: Activity) {
        NetworkManager.shared.requestData(from: activity.profileURL) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func configureProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageHeight / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.clipsToBounds = true
    }
}
