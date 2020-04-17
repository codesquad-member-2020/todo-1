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
    private let fontSize: CGFloat = 17
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureProfileImageView()
    }
    
    func updateCell(with activity: Activity) {
        fetchImage(with: activity.profileURL)
        actionLabel.attributedText = generateActionLabel(with: activity)
        timeLabel.text = generateActionTimeLabel(with: activity.actionTime)
    }
    
    func generateActionTimeLabel(with actionTime: String) -> String {
        var timeText = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.s"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: +9)
        let actionDate = dateFormatter.date(from: actionTime)!
        
        let now = Date()
        
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: +9)!
        
        let components = calendar.dateComponents([.hour, .minute], from: actionDate, to: now)
        
        guard let hours = components.hour else { return "" }
        let calculatedHours = 9 + hours - 1
        if calculatedHours < 1 {
            guard let minutes = components.minute else { return "" }
            let calculatedMinutes = 60 + minutes
            timeText = calculatedMinutes <= 1 ? "a minute" : "\(calculatedMinutes) minutes"
        } else if calculatedHours == 1 {
            timeText = "an hour"
        } else {
            timeText = "\(calculatedHours) hours"
        }
        
        return "\(timeText) ago"
    }
    
    private func generateActionLabel(with activity: Activity) -> NSAttributedString {
        let userId = activity.userId
        let action = activity.action
        let title = activity.title
        
        let attributedText = NSMutableAttributedString(string: "@\(userId) ", attributes:
            [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
             .foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)])
        
        var actionBehavior = ""
        var firstProposition = ""
        var secondProposition = ""
        var fromColumn = ""
        var toColumn = ""
        
        switch action {
        case "add":
            actionBehavior = "added "
            firstProposition = "to "
            toColumn = "\(activity.toColumn) "
            break
        case "removed":
            actionBehavior = "removed "
            secondProposition = "at "
            toColumn = "\(activity.toColumn) "
            break
        case "move":
            actionBehavior = "moved "
            firstProposition = "from "
            fromColumn = "\(activity.fromColumn) "
            secondProposition = "to "
            toColumn = "\(activity.toColumn) "
            break
        case "update":
            actionBehavior = "edited as "
            secondProposition = "at "
            toColumn = "\(activity.toColumn) "
            break
        default:
            break
        }
        
        attributedText.append(NSAttributedString(string: actionBehavior, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\(title) ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)]))
        attributedText.append(NSAttributedString(string: firstProposition, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        attributedText.append(NSAttributedString(string: fromColumn, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)]))
        attributedText.append(NSAttributedString(string: secondProposition, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        attributedText.append(NSAttributedString(string: toColumn, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)]))
        return attributedText
    }
    
    private func fetchImage(with profileURL: String) {
        NetworkManager.shared.requestData(from: profileURL) { (result) in
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
        profileImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        self.profileImageView.image = nil
    }
}
