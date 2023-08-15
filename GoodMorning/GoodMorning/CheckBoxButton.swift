//
//  CheckBoxButton.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

final class CheckBoxButton: UIButton {

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
        tintColor = .black
        layer.cornerRadius = 10
        layer.borderColor = UIColor.design(.checkBox)?.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 1
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        updateCheckMarkImage()
    }

    @objc private  func didButtonTapped() {
        isSelected.toggle()
    }

    private func updateCheckMarkImage() {
        self.setImage(UIImage.checkmark, for: .selected)
        self.setImage(nil, for: .normal)
    }

}

fileprivate extension UIImage {

    static var checkmark: UIImage? {
        let SFSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .bold,
            scale: .large
        )

        let SFSymbolImage = UIImage(
            systemName: "checkmark",
            withConfiguration: SFSymbolConfiguration
        )

        return SFSymbolImage
    }

}
