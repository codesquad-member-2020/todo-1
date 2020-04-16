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
    func editCard(_ card: Card, at row: Int)
}

class CardEditorViewController: UIViewController {

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
    private var userInfo: UserInfo!
    private var columnId: Int!
    private var cardId: Int?
    private var row: Int!
    
    private var isCardEditing: Bool = false
    
    var newCardDelegate: NewCardDelegation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModels()
        configureDelegates()
        configureNotification()
        configureTextFieldFirstResponder()
    }
    
    func updateCard(_ card: Card?) {
        guard let card = card else { return }
        self.cardId = card.identifier
        self.titleTextField.text = card.title
        self.contentsTextView.text = card.contents
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
        let cardRequest = NewCardRequest(userId: userInfo.userId, title: titleText, contents: contentsText)
        if isCardEditing {
            requestEditCard(cardRequest)
        } else {
            requestAddNewCard(cardRequest)
        }
    }
    
    private func requestAddNewCard(_ cardRequest: NewCardRequest) {
        NetworkManager.shared.requestDataWithBody(method: .post, body: cardRequest, columnId: columnId) { (result: Result<CardContainer, RequestError>) in
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
    
    private func requestEditCard(_ cardRequest: NewCardRequest) {
        NetworkManager.shared.requestDataWithBody(method: .put, body: cardRequest, columnId: columnId, cardId: cardId) { (result: Result<CardContainer, RequestError>) in
            switch result {
            case .success(let cardContainer):
                let card = cardContainer.card
                self.editCard(card)
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    private func editCard(_ card: Card) {
        DispatchQueue.main.async {
            self.newCardDelegate?.editCard(card, at: self.row)
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
    
    func configureIsCardEditing(_ isCardEditing: Bool) {
        self.isCardEditing = isCardEditing
    }
    
    func configureRow(_ row: Int?) {
        guard let row = row else { return }
        self.row = row
    }
    
    func configureColumnId(_ id: Int) {
        self.columnId = id
    }
    
    func configureUserInfo(_ userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
