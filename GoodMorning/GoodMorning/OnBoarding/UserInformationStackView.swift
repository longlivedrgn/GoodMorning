//
//  UserInformationStackView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import UIKit

final class UserInformationStackView: UIStackView {

    private(set) var titleLabel: PretendardLabel

    override init(frame: CGRect) {
        self.titleLabel = PretendardLabel(text: "", size: 10, weight: .medium)
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, subView: UIView) {
        self.init(frame: .zero)
        self.titleLabel = PretendardLabel(text: title, alignment: .left, size: 20, weight: .bold)
        self.addArrangedSubviews([self.titleLabel, subView])
        self.axis = .vertical
        self.spacing = 10
    }

}
