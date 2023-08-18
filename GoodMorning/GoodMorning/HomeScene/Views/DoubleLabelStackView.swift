//
//  DoubleLabelStackView.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import UIKit

final class DoubleLabelStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(type: LabelType, nickName: String) {
        self.init(frame: .zero)

        let firstLabel = PretendardLabel(
            text: type.first,
            alignment: .left,
            size: 45,
            weight: .heavy
        )
        let secondLabel = PretendardLabel(
            text: nickName + type.second,
            alignment: .left,
            size: 30,
            weight: .bold)
        self.addArrangedSubviews([firstLabel, secondLabel])
        self.configureDoubleLabelStackView(spacing: 10)
    }

    convenience init(type: LabelType) {
        self.init(frame: .zero)

        let firstLabel = PretendardLabel(
            text: type.first,
            size: 30,
            weight: .semibold
        )
        let secondLabel = PretendardLabel(
            text: type.second,
            color: .gray,
            size: 17,
            weight: .regular)
        self.addArrangedSubviews([firstLabel, secondLabel])
        self.configureDoubleLabelStackView(spacing: 3)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDoubleLabelStackView(spacing: CGFloat) {
        self.axis = .vertical
        self.distribution = .fillProportionally
        self.spacing = spacing
    }

}

extension DoubleLabelStackView {
    enum LabelType {
        case title
        case luck

        var first: String {
            switch self {
            case .title:
                return Date.now.description
            case .luck:
                return "오늘의 운세"
            }
        }

        var second: String {
            switch self {
            case .title:
                return "님, 굿모닝☀️"
            case .luck:
                return "굿모닝에게 물어보세요!"
            }
        }
    }

}

fileprivate extension Date {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "M월 d일"

        let formattedDate = dateFormatter.string(from: self)

        return formattedDate
    }

}
