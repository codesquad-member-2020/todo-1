//
//  NewCardViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

protocol NewCardDelegation {
    func addNewCard(_ card: Card)
}

class NewCardViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var contentsPlaceholderLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    
    private var titleText: String = ""
    private var contentsText: String = ""
    
    private var titleViewModel: TitleViewModel?
    private var contentsViewModel: ContentsViewModel?
    private var titleDelegate: CardTitleTextFieldDelegate?
    private var contentsDelegate: CardContentsTextViewDelegate?
    
    private let device = "iOS"
    
    private var columnId: Int = 0
    
    var newCardDelegate: NewCardDelegation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModels()
        configureDelegates()
        configureNotification()
        configureTextFieldFirstResponder()
    }
    
    private func configureTextFieldFirstResponder() {
        titleTextField.becomeFirstResponder()
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didFinishReturnTitle),
                                               name: .didFinishReturnCardTitleNotification,
                                               object: nil)
    }
    
    @objc func didFinishReturnTitle(notification: Notification) {
        contentsTextView.becomeFirstResponder()
    }
    
    private func configureDelegates() {
        titleDelegate = CardTitleTextFieldDelegate(titleViewModel: titleViewModel)
        contentsDelegate = CardContentsTextViewDelegate(contentsViewModel: contentsViewModel)
        
        titleTextField.delegate = titleDelegate
        contentsTextView.delegate = contentsDelegate
    }
    
    private func configureViewModels() {
        titleViewModel = TitleViewModel { (title) in
            self.titleText = title
            self.updateButtonValidation()
        }
        contentsViewModel = ContentsViewModel(changed: { (contents) in
            self.contentsText = contents
            self.updateContentsPlaceholderLabel()
            self.updateButtonValidation()
        })
    }
    
    private func updateContentsPlaceholderLabel() {
        contentsPlaceholderLabel.isHidden = contentsText != ""
    }
    
    private func updateButtonValidation() {
        addCardButton.isEnabled = (titleText != "") && (contentsText != "")
    }
    
    @IBAction func addNewCardTapped(_ sender: Any) {
        let newCardRequest = NewCardRequest(userId: "cory", title: titleText, contents: contentsText)
        NetworkManager.shared.requestDataWithBody(method: .post, body: newCardRequest, optionalData: columnId) { (result: Result<CardContainer, RequestError>) in
            switch result {
            case .success(let cardContainer):
                let card = cardContainer.card
                self.addNewCard(card)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func addNewCard(_ card: Card) {
        DispatchQueue.main.async {
            self.newCardDelegate?.addNewCard(card)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func showErrorAlert(error: RequestError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failed to add card", message: error.description, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Done", style: .default, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setColumnId(_ id: Int) {
        self.columnId = id
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
