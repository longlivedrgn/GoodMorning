//
//  TODOHeaderView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

class TODOHeaderView: UICollectionReusableView {

    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.darkGray, for: .normal)

        return button
    }()

    private let plusTODOButton: UIButton = {
        let button = UIButton()
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
//        self.snp.makeConstraints { make in
//            make.height.equalTo(100)
//        }
        addSubview(editButton)
        addSubview(plusTODOButton)

        editButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }

        plusTODOButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
    }

}
