//
//  NewCardViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var contentsPlaceholderLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    
    var column: Column!
    
    let contentsTextViewDelegate = CardContetnsTextViewDelegate()
    let titleTextFieldDelegate = CardTitleTextFieldDelegate()
    let viewModel = NewCardViewModel()
    
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
        contentsTextViewDelegate.viewModel = viewModel
        titleTextFieldDelegate.viewModel = viewModel
    }
    
    private func configureViewModelHandler() {
        viewModel.buttonStateChanged = { canAddCard in
            self.addCardButton.isEnabled = canAddCard
        }
        viewModel.contentNilStatusChanged = { isEmpty in
            self.contentsPlaceholderLabel.isHidden = !isEmpty
        }
    }
    
    @IBAction func addNewCardTapped(_ sender: Any) {
        print(column.name)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
