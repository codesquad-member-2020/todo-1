//
//  CardContetnsTextViewDelegate.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardContetnsTextViewDelegate: NSObject, UITextViewDelegate {
    
    private let placeholder: String = "내용을 입력해주세요"
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updatePlaceholder(textView: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            updatePlaceholder(textView: textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text else { return true }
        let estimatedTextCount = textViewText.count + text.count - range.length
        return estimatedTextCount <= 500
    }
    
    private func updatePlaceholder(textView: UITextView) {
        guard let text = textView.text else { return }
        if text == placeholder {
            textView.text = ""
            textView.textColor = .black
        } else if text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}
