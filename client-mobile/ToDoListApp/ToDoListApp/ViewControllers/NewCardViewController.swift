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
    @IBOutlet weak var contentsTextView: CardContentsTextView!
    @IBOutlet weak var addCardButton: UIButton!
    
    let contentsTextViewDelegate = CardContetnsTextViewDelegate()
    let titleTextFieldDelegate = CardTitleTextFieldDelegate()
    let viewModel = NewCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentsTextView.delegate = contentsTextViewDelegate
        titleTextField.delegate = titleTextFieldDelegate
        contentsTextViewDelegate.viewModel = viewModel
        titleTextFieldDelegate.viewModel = viewModel
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel.buttonStateChanged = { canAddCard in
            self.addCardButton.isEnabled = canAddCard
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
