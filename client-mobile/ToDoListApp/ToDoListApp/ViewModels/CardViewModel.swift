//
//  NewCardViewModel.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/08.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

class CardViewModel {
    
    var title: String = "" { didSet { checkValidation() } }
    var contents: String = "" { didSet { checkContents() } }
    var device: String = "iPad"
    var canAddCard: Bool = false { didSet { buttonStatusChanged?(canAddCard) } }
    var isContentsEmpty: Bool = true { didSet { contentNilStatusChanged?(isContentsEmpty) } }
    
    var contentNilStatusChanged: ((Bool) -> Void)?
    var buttonStatusChanged: ((Bool) -> Void)?
    
    private func checkValidation() {
        canAddCard = (title != "") && (contents != "")
    }
    
    private func checkContents() {
        isContentsEmpty = (contents == "")
        checkValidation()
    }
}
