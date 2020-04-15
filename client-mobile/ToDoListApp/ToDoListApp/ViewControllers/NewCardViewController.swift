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
        let card = Card(userID: "Sunny", title: titleText, contents: contentsText, device: device, index: 0)
        newCardDelegate?.addNewCard(card)
        dismiss(animated: true, completion: nil)
    }
    
    func setColumnId(_ id: Int) {
        self.columnId = id
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
