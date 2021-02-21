//
//  LoginTextField.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 20.02.2021.
//

import UIKit

class LoginTextField : UITextField {
    
    let textPadding = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 2,
            right: 0
        )

    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

    init(bounds: CGRect, placeholder: String) {
        super.init(frame: bounds)
        self.borderStyle = .none
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 15
        self.contentVerticalAlignment = .center
        self.textAlignment = .left
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.placeholder = placeholder
        self.textColor = .black
        self.font = .systemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
