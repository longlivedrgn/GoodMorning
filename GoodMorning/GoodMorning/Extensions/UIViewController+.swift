//
//  UIViewController+.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/26.
//

import UIKit

extension UIViewController {

    func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIViewController.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIViewController.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height

        let currentOriginOfY = self.view.frame.origin.y
        if currentOriginOfY == 0 {
            self.view.frame.origin.y -= keyboardHeight
        } else {
            self.view.frame.origin.y -= currentOriginOfY + keyboardHeight
        }

    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

}
