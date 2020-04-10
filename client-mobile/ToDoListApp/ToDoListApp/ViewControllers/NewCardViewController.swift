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
    
    let cardViewModel = CardViewModel()
    
    private var titleViewModel: TitleViewModel?
    private var contentsViewModel: ContentsViewModel?
    private var titleDelegate: CardTitleTextFieldDelegate?
    private var contentsDelegate: CardContentsTextViewDelegate?
    
    var delegate: NewCardDelegation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModels()
        configureDelegates()
        configureViewModelHandler()
    }
    
    private func configureDelegates() {
        titleDelegate = CardTitleTextFieldDelegate(titleViewModel: titleViewModel)
        contentsDelegate = CardContentsTextViewDelegate(contentsViewModel: contentsViewModel)
        
        titleTextField.delegate = titleDelegate
        contentsTextView.delegate = contentsDelegate
    }
    
    private func configureViewModels() {
        titleViewModel = TitleViewModel { (title) in
            print(title)
        }
        contentsViewModel = ContentsViewModel(changed: { (contents) in
            print(contents)
        })
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
        cardViewModel.index = column.numberOfCards
        let card = Card(viewModel: cardViewModel)
        self.dismiss(animated: true) {
            self.delegate?.addNewCard(card)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
