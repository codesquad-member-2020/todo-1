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
    
    var column: Column!
    
    let contentsTextViewDelegate = CardContetnsTextViewDelegate()
    let titleTextFieldDelegate = CardTitleTextFieldDelegate()
    let cardViewModel = CardViewModel()
    
    var delegate: NewCardDelegation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegates()
        configureViewModel()
        configureViewModelHandler()
    }
    
    private func configureDelegates() {
        contentsTextView.delegate = contentsTextViewDelegate
        titleTextField.delegate = titleTextFieldDelegate
    }
    
    private func configureViewModel() {
        contentsTextViewDelegate.cardViewModel = cardViewModel
        titleTextFieldDelegate.cardViewModel = cardViewModel
    }
    
    private func configureViewModelHandler() {
        cardViewModel.buttonStatusChanged = { canAddCard in
            self.addCardButton.isEnabled = canAddCard
        }
        cardViewModel.contentNilStatusChanged = { isEmpty in
            self.contentsPlaceholderLabel.isHidden = !isEmpty
        }
    }
    
    @IBAction func addNewCardTapped(_ sender: Any) {
        let card = Card(viewModel: cardViewModel)
        self.dismiss(animated: true) {
            self.delegate?.addNewCard(card)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
