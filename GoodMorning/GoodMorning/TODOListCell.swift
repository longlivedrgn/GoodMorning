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
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let checkBoxButton = CheckBoxButton()

    func updateWithItem(_ newItem: Item) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }

    func addLine(fromPoint start: CGPoint, toPoint end: CGPoint, priority: Priority) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = priority.color.cgColor
        line.lineWidth = 8
        line.lineJoin = CAShapeLayerLineJoin.round
        contentView.layer.addSublayer(line)
        contentView.clipsToBounds = true
    }

    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item
        return state
    }

    private func setupViewsIfNeeded() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.addSubview(listContentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(checkBoxButton)

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(3)
            make.width.equalTo(iconImageView.snp.height)
        }
        checkBoxButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(iconImageView.snp.height).multipliedBy(0.8)
            make.width.equalTo(checkBoxButton.snp.height)
            make.trailing.equalToSuperview().inset(15)
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
        iconImageView.image = state.item?.iconImage

        let start = contentView.bounds.origin
        let end = CGPoint(x: start.x, y: start.y + contentView.bounds.height)
        addLine(fromPoint: start, toPoint: end, priority: state.item?.priority ?? .high)

    }
}
