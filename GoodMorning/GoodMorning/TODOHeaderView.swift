//
//  TODOHeaderView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

class TODOHeaderView: UICollectionReusableView {

    weak var delegate: TODOHeaderViewDelegate?

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside
        )
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.darkGray, for: .normal)

        return button
    }()

    private lazy var plusTODOButton: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside
        )
        let SFSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold,
            scale: .large
        )
        let SFSymbolImage = UIImage(
            systemName: "plus.circle",
            withConfiguration: SFSymbolConfiguration
        )

        button.setImage(
            SFSymbolImage?.withTintColor(.black, renderingMode: .alwaysOriginal),
            for: .normal
        )

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        addSubview(editButton)
        addSubview(plusTODOButton)

        editButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }

        plusTODOButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
    }

    @objc private func editButtonTapped(_ sender: UIButton) {
        delegate?.TODOHeaderView(self, didEditButtonTapped: sender)
    }

    @objc private func plusButtonTapped(_ sender: UIButton) {
        delegate?.TODOHeaderView(self, didPlusButtonTapped: sender)
    }

}
