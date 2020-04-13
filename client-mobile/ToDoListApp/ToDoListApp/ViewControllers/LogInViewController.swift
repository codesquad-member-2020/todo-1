//
//  LogInViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/14.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userNameTextField: LogInTextField!
    @IBOutlet weak var passwordTextField: LogInTextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    static let identifier = "LogIn"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    private func configureViewsCornerRadius() {
        userNameTextField.layer.cornerRadius = 12
        passwordTextField.layer.cornerRadius = 12
        logInButton.layer.cornerRadius = 12
        signUpButton.layer.cornerRadius = 12
    }
    
    private func configureViews() {
        configureViewsCornerRadius()
        let backgroundEffectView = UIView()
        backgroundEffectView.backgroundColor = .lightGray
        backgroundView.addSubview(backgroundEffectView)
        backgroundEffectView.translatesAutoresizingMaskIntoConstraints = false
        backgroundEffectView.alpha = 0.4
        backgroundEffectView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        backgroundEffectView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        backgroundEffectView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        backgroundEffectView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        
        // Blurry Effect View
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.layer.cornerRadius = 64
        visualEffectView.clipsToBounds = true
        backgroundView.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visualEffectView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        visualEffectView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        visualEffectView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
}
