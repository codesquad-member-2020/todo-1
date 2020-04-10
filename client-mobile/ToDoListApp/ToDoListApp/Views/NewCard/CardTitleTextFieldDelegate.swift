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
    
    private var titleViewModel: TitleViewModel?
    
    init(titleViewModel: TitleViewModel?) {
        self.titleViewModel = titleViewModel
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        titleViewModel?.update(with: text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text else { return true }
        let estimatedTextCount = textFieldText.count + string.count - range.length
        return estimatedTextCount <= titleTextCountLimitation
    }
}
