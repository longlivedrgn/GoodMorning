//
//  TODOListCell.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import Foundation
import UIKit

fileprivate extension UIConfigurationStateCustomKey {

    static let item = UIConfigurationStateCustomKey("com.GoodMoring.TODOListCell.item")

}

private extension UICellConfigurationState {

    var item: Item? {
        set { self[.item] = newValue }
        get { return self[.item] as? Item }
    }

}

class TODOListCell: UICollectionViewListCell {
    private var item: Item?
    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .cell()
    }
    private lazy var listContentView = UIListContentView(
        configuration: defaultListContentConfiguration()
    )
    private let iconImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.backgroundColor = .red

        return imageView
    }()
    // 여기에 button 넣기

    func updateWithItem(_ newItem: Item) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }

    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item
        return state
    }

    private func setupViewsIfNeeded() {
        contentView.addSubview(listContentView)
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(iconImageView.snp.height)
        }
        listContentView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing)
        }
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        var content = defaultListContentConfiguration().updated(for: state)
        content.attributedText = NSAttributedString(
            string: state.item?.description ?? "",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        )
        listContentView.configuration = content

        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        iconImageView.image = state.item?.iconImage
    }
}
