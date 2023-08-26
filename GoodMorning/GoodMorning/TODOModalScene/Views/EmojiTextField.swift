//
//  EmojiTextField.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/27.
//

import UIKit

final class EmojiTextField: UITextField {

//    override var textInputContextIdentifier: String? { "" }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        configureEmojiTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes where mode.primaryLanguage == "emoji" {
            return mode
        }
        return nil
    }

    private func configureEmojiTextField() {
        self.text = "📚"
        self.font = .pretendard(size: 35, weight: .bold)
        self.tintColor = .clear
    }

}
