//
//  TODOListCell.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit
import SnapKit

final class ToDoListCell: UICollectionViewListCell {

    private var item: ToDoItem?

    private let checkBoxButton = CheckBoxButton()
    private lazy var TODOListContentView = UIListContentView(
        configuration: defaultListContentConfiguration()
    )
    private let iconImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.layer.configureBorder(cornerRadius: 0)
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
            string: state.item?.title ?? "",
            attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        )
        TODOListContentView.configuration = content
//        iconImageView.image = state.item?.iconImage

        configureLine(with: state)
    }

    func updateWithItem(_ newItem: ToDoItem) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }

    func configureDelegate(_ delegate: CheckBoxButtonDelegate) {
        self.checkBoxButton.delegate = delegate
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
        contentView.layer.configureBorder()
        configureSubViews()
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

fileprivate extension UICellConfigurationState {

    var item: ToDoItem? {
        get {
            return self[UIConfigurationStateCustomKey.item] as? ToDoItem
        }
        set {
            self[UIConfigurationStateCustomKey.item] = newValue
        }
    }

}

fileprivate extension UIConfigurationStateCustomKey {

    static let item = UIConfigurationStateCustomKey("TODOListCell.item")

}
