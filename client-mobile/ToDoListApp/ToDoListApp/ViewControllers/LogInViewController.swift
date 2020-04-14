//
//  LogInViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/14.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    static let identifier = "LogIn"
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userNameTextField: LogInTextField!
    @IBOutlet weak var passwordTextField: LogInTextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var userName: String = "" {
        didSet { checkValidation() }
    }
    private var password: String = "" {
        didSet { checkValidation() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    @IBAction func userNameChanged(_ textField: UITextField) {
        userName = textField.text ?? ""
    }
    
    @IBAction func passwordChanged(_ textField: UITextField) {
        password = textField.text ?? ""
    }
    
    private func checkValidation() {
        let isValid = userName != "" && password != ""
        logInButton.isEnabled = isValid
        logInButton.backgroundColor = isValid ? UIColor(named: "LogInButtonColor") : .lightGray
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
    }
    
    private func configureViewsCornerRadius() {
        userNameTextField.layer.cornerRadius = 12
        passwordTextField.layer.cornerRadius = 12
        logInButton.layer.cornerRadius = 12
        signUpButton.layer.cornerRadius = 12
    }
    
    private func configureButtonInterface() {
        logInButton.setTitleColor(.darkGray, for: .disabled)
        logInButton.setTitleColor(.white, for: .normal)
    }
    
    private func configureViews() {
        configureViewsCornerRadius()
        configureButtonInterface()
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
