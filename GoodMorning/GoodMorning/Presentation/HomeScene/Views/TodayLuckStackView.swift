//
//  TodayLuckStackView.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import UIKit

final class TodayLuckStackView: UIStackView {

    private let dobleLabel = DoubleLabelStackView(type: .luck)

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.SFSymbol(.luck))
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.tintColor = .black
        return imageView
    }()

    init() {
        super.init(frame: .zero)

        self.setupStackView()
        self.configureStackView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.configureStackViewMargins()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        self.addArrangedSubviews([imageView, dobleLabel])
    }

    private func configureStackView() {
        self.distribution = .fill
        self.alignment = .fill
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
    }

    private func configureStackViewMargins() {
        self.isLayoutMarginsRelativeArrangement = true

        let verticalMargins: CGFloat = self.frame.height * 0.126
        let horizontalMargins: CGFloat = self.frame.width * 0.115
        self.layoutMargins = .init(
            top: verticalMargins,
            left: horizontalMargins,
            bottom: verticalMargins,
            right: horizontalMargins
        )
    }
}
