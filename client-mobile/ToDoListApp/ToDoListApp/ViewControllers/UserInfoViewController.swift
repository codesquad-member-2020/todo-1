//
//  UserInfoViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/13.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate {
    func didTapSignOut()
}

class UserInfoViewController: UIViewController {

    static let identifier = "userInfo"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userSettingButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let imageViewHeight: CGFloat = 72
    
    var delegate: UserInfoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoadingView()
        configureImageView()
        configureButtonsCornerRadius()
    }
    
    private func startLoadingView() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopLoadingView() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func configureImageView() {
        imageView.layer.cornerRadius = imageViewHeight / 2
    }

    private func configureButtonsCornerRadius() {
        userSettingButton.layer.cornerRadius = 8
        logoutButton.layer.cornerRadius = 8
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.didTapSignOut()
        })
    }
    
    func updateUserInfoView(with userInfo: UserInfo) {
        NetworkManager.shared.requestData(from: userInfo.profileURL) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.stopLoadingView()
                }
            case .failure(_):
                break
            }
        }
        self.nameLabel.text = userInfo.userId
        self.emailLabel.text = "\(userInfo.userId)@gmail.com"
    }
}
