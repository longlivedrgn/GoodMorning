//
//  TODOListCell.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import Foundation
import UIKit
import SnapKit

fileprivate extension UIConfigurationStateCustomKey {

    static let item = UIConfigurationStateCustomKey("TODOListCell.item")

}

private extension UICellConfigurationState {

    var item: TODOItem? {
        get {
            return self[UIConfigurationStateCustomKey.item] as? TODOItem
        }
        set {
            self[UIConfigurationStateCustomKey.item] = newValue
        }
    }

}

class TODOListCell: UICollectionViewListCell {

    private var item: TODOItem?

    private let checkBoxButton = CheckBoxButton()
    private lazy var TODOListContentView = UIListContentView(
        configuration: defaultListContentConfiguration()
    )
    private let iconImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item

        return state
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()

        var content = defaultListContentConfiguration().updated(for: state)
        content.attributedText = NSAttributedString(
            string: state.item?.description ?? "",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        )
        TODOListContentView.configuration = content
        iconImageView.image = state.item?.iconImage

        configureLine(with: state)
    }

    func updateWithItem(_ newItem: TODOItem) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }

    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .cell()
    }

    private func addLine(fromPoint start: CGPoint, toPoint end: CGPoint, priority: Priority) {
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

    private func setupViewsIfNeeded() {
        configureLayer()
        configureSubViews()
    }

    private func configureLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
    }

    private func configureSubViews() {
        contentView.addSubview(TODOListContentView)
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
        TODOListContentView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing)
        }
    }

    private func configureLine(with state: UICellConfigurationState) {
        let start = contentView.bounds.origin
        let end = CGPoint(x: start.x, y: start.y + contentView.bounds.height)

        addLine(fromPoint: start, toPoint: end, priority: state.item?.priority ?? .high)
    }

}
