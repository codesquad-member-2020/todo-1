//
//  ActivityViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/17.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var activities: [Activity] = [] {
        didSet { self.tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchActivities()
        configureTableView()
    }
    
    private func fetchActivities() {
        NetworkManager.shared.requestData(path: "/api/activity") { (result: Result<ActivityContainer, RequestError>) in
            
            switch result {
            case .success(let activityContainer):
                DispatchQueue.main.async {
                    self.activities = activityContainer.activities
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
}

extension ActivityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.identifier, for: indexPath) as! ActivityCell
        let activity = activities[indexPath.item]
        cell.updateCell(with: activity)
        return cell
    }
}
