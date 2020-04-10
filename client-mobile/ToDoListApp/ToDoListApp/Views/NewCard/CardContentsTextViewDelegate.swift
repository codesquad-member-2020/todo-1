//
//  CardContetnsTextViewDelegate.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardContentsTextViewDelegate: NSObject, UITextViewDelegate {
    
    private let placeholder: String = "내용을 입력해주세요"
    private let contentsTextCountLimitation: Int = 500
    
    private var contentsViewModel: ContentsViewModel?
    
    init(contentsViewModel: ContentsViewModel?) {
        self.contentsViewModel = contentsViewModel
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let text = textView.text else { return }
        contentsViewModel?.update(with: text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text else { return true }
        let estimatedTextCount = textViewText.count + text.count - range.length
        return estimatedTextCount <= contentsTextCountLimitation
    }
}
