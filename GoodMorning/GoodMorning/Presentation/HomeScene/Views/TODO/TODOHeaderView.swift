//
//  ToDoHeaderView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

final class ToDoHeaderView: UICollectionReusableView {

    weak var delegate: ToDoHeaderViewDelegate?

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
        let button = UIButton(type: .contactAdd)
        button.tintColor = .black
        button.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside
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
        delegate?.ToDoHeaderView(self, didEditButtonTapped: sender)
    }

    @objc private func plusButtonTapped(_ sender: UIButton) {
        delegate?.ToDoHeaderView(self, didPlusButtonTapped: sender)
    }

}
