//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
      
    @IBOutlet weak var stackView: UIStackView!
    private var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = loadToken() {
            configureToDoList(with: token)
        } else {
            presentToLogIn()
        }
    }
    
    private func loadToken() -> String? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.token
    }
    
    private func saveToken(_ token: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let tokenManager = appDelegate?.tokenManager
        tokenManager?.saveToken(token)
    }
    
    private func presentToLogIn() {
        let logInViewController = storyboard?.instantiateViewController(identifier: LogInViewController.identifier) as! LogInViewController
        logInViewController.modalPresentationStyle = .fullScreen
        present(logInViewController, animated: true, completion: {
            logInViewController.delegate = self
        })
    }
    
    private func configureToDoList(with token: String) {
        requestColumnsData(with: token) { (columns) in
            DispatchQueue.main.async {
                self.configureColumns(columns)
            }
        }
    }
    
    private func resetColumnViewControllers() {
        children.forEach {
            $0.removeFromParent()
        }
        stackView.removeAll()
    }
    
    private func configureColumns(_ columns: [Column]) {
        resetColumnViewControllers()
        for column in columns {
            guard let columnViewController = storyboard?.instantiateViewController(identifier: ColumnViewController.identifier) as? ColumnViewController else { return }
            self.addChild(columnViewController)
            self.stackView.addArrangedSubview(columnViewController.view)
            columnViewController.columnViewModel = ColumnViewModel()
            columnViewController.updateColumn(column)
            columnViewController.setColumnId(column.identifier)
        }
    }
    
    @IBAction func userInfoButtonTapped(_ sender: UIBarButtonItem) {
        guard let userInfoViewController = storyboard?.instantiateViewController(identifier: UserInfoViewController.identifier) as? UserInfoViewController else { return }
        userInfoViewController.modalPresentationStyle = .popover
        self.present(userInfoViewController, animated: true) {
            
        }
        userInfoViewController.popoverPresentationController?.barButtonItem = sender
    }
}

extension HomeViewController {
    
    private func requestColumnsData(with token: String, completion: @escaping ([Column]) -> Void) {
        NetworkManager.shared.requestData(token: token) { (result: Result<UserData, RequestError>) in
            switch result {
            case .success(let userData):
                completion(userData.columns)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func showErrorAlert(error: RequestError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Done", style: .default, handler: nil)
            let retryAction = UIAlertAction(title: "Retry", style: .cancel) { _ in
                self.configureToDoList(with: "")
            }
            alert.addAction(retryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: LogInViewControllerDelegate {
    func didSuccessToLogIn(with logInInfo: (String, UserInfo)) {
        let token = logInInfo.0
        let userInfo = logInInfo.1
        saveToken(token)
        self.userInfo = userInfo
    }
}
