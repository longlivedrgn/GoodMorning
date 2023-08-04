//
//  CheckBoxButton.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

class CheckBoxButton: UIButton {

    var isChecked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAttributes() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        setButtonTitle()
    }

    func setButtonTitle() {
    }
}
