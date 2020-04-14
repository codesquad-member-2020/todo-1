//
//  LogInViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/14.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

protocol LogInViewControllerDelegate {
    func didSuccessToLogIn(with token: String)
}

class LogInViewController: UIViewController {

    static let identifier = "LogIn"
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userNameTextField: LogInTextField!
    @IBOutlet weak var passwordTextField: LogInTextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var delegate: LogInViewControllerDelegate?
    
    private let buttonsCornerRadius: CGFloat = 12
    
    private var userName: String = "" {
        didSet { checkValidation() }
    }
    private var password: String = "" {
        didSet { checkValidation() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewsCornerRadius()
        configureButtonInterface()
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
        let user = User(userName: userName, password: password)
        NetworkManager.shared.requestLogIn(user: user) { (result) in
            switch result {
            case .success(let token):
                self.dismissCurrentViewController(with: token)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func dismissCurrentViewController(with token: String) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.delegate?.didSuccessToLogIn(with: token)
            }
        }
    }
    
    private func showErrorAlert(error: RequestError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failed to Log In", message: error.description, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Done", style: .default, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureViewsCornerRadius() {
        userNameTextField.layer.cornerRadius = buttonsCornerRadius
        passwordTextField.layer.cornerRadius = buttonsCornerRadius
        logInButton.layer.cornerRadius = buttonsCornerRadius
        signUpButton.layer.cornerRadius = buttonsCornerRadius
    }
    
    private func configureButtonInterface() {
        logInButton.setTitleColor(.darkGray, for: .disabled)
        logInButton.setTitleColor(.white, for: .normal)
    }
}

extension LogInViewController {
    
    private func configureViews() {
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
