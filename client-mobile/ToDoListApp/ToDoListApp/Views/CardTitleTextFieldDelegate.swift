//
//  CardTitleTextFieldDelegate.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardTitleTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let titleTextCountLimitation: Int = 19
    
    var viewModel: NewCardViewModel?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text else { return true }
        viewModel?.title = "\(textFieldText)\(string)"
        let estimatedTextCount = textFieldText.count + string.count - range.length
        return estimatedTextCount <= titleTextCountLimitation
    }
}
