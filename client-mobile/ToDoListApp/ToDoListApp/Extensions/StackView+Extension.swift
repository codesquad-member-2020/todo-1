//
//  StackView+Extension.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/16.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import UIKit

extension UIStackView {
    
    /// Remove arranged subviews in UIStackView
    func removeAll() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
