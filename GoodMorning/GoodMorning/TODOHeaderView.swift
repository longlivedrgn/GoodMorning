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
        button.setTitleColor(.gray, for: .normal)

        return button
    }()

    private let plusTODOButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)

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

}
