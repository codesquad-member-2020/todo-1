//
//  NewCardViewController.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController {

    @IBOutlet weak var contentsTextView: CardContentsTextView!
    
    let contentsTextViewDelegate = CardContetnsTextViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentsTextView.delegate = contentsTextViewDelegate
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
