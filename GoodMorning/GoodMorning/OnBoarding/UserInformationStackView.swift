//
//  UserInformationStackView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import UIKit

final class UserInformationStackView: UIStackView {

    private(set) var titleLabel: PretendardLabel

    init(title: String, subView: UIView) {
        self.titleLabel = PretendardLabel(text: title, alignment: .left, size: 20, weight: .bold)
        super.init(frame: .zero)
        self.configureStackView(with: subView)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStackView(with subView: UIView) {
        self.addArrangedSubviews([self.titleLabel, subView])
        self.axis = .vertical
        self.spacing = 10
    }

}
