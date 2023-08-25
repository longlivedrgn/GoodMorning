//
//  UserInformationStackView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import UIKit

class UserInformationStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, subView: UIView) {
        self.init(frame: .zero)

        let titleLabel = PretendardLabel(text: title, size: 18, weight: .regular)
        self.addArrangedSubviews([titleLabel, subView])

        self.axis = .vertical
    }

}
