//
//  CheckBoxButton.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

final class CheckBoxButton: UIButton {

    var isChecked = false {
        didSet {
            self.updateCheckMarkImage()
        }
    }

    weak var delegate: CheckBoxButtonDelegate?

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
        layer.borderColor = UIColor.design(.checkBox)?.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 1
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        updateCheckMarkImage()
    }

    @objc private  func didButtonTapped() {
        isChecked.toggle()
    }

    private func updateCheckMarkImage() {
        if isChecked {
            self.setImage(UIImage.checkmark, for: .normal)
        } else {
            self.setImage(nil, for: .normal)
        }
    }

}
