//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/06.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, LogInViewControllerDelegate {
      
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureToDoList()
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
    
    func didSuccessToLogIn(with token: String) {
        
    }
    
    private func configureToDoList() {
        requestColumnsData { (columns) in
            DispatchQueue.main.async {
                self.configureColumns(columns)
            }
        }
    }
    
    private func requestColumnsData(completion: @escaping ([Column]) -> Void) {
        NetworkManager.shared.requestData(method: .get) { (result) in
            switch result {
            case .success(let columns):
                guard let columns = columns else { return }
                completion(columns)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func showErrorAlert(error: RequestError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .cancel) { _ in
            self.configureToDoList()
        }
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureColumns(_ columns: [Column]) {
        for column in columns {
            guard let columnViewController = storyboard?.instantiateViewController(identifier: ColumnViewController.identifier) as? ColumnViewController else { return }
            self.addChild(columnViewController)
            self.stackView.addArrangedSubview(columnViewController.view)
            columnViewController.columnViewModel = ColumnViewModel()
            columnViewController.updateColumn(column)
        }
    }
}

