//
//  UserInfoViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/13.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    static let identifier = "userInfo"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userSettingButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonsCornerRadius()
    }

    private func configureButtonsCornerRadius() {
        userSettingButton.layer.cornerRadius = 8
        logoutButton.layer.cornerRadius = 8
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        
    }
}
