//
//  CustomTextField.swift
//  pryaniki
//
//  Created by George Tevosov on 28.05.2022.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    

    override func canPerformAction(_ action: ObjectiveC.Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        .null
    }
}
