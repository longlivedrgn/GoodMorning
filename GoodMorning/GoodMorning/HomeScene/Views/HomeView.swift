//
//  HomeView.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import UIKit
import SnapKit

final class HomeView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    private let titleStackView = DoubleLabelStackView(type: .title, nickName: "Miro")
    private let routineCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        // 추후 크기 조정
        collectionView.heightAnchor.constraint(equalToConstant: 258).isActive = true
        return collectionView
    }()
    private let weatherStackView = WeatherStackView(weather: .drizzle, temperature: 27)

    init() {
        super.init(frame: .zero)

        setupView()
        configureView()
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureContentViewMargins()
        configureWeatherStackView()
    }

    private func configureContentViewMargins() {
        contentView.isLayoutMarginsRelativeArrangement = true

        let layoutMargins = self.frame.width * 0.058
        contentView.layoutMargins = .init(
            top: layoutMargins,
            left: layoutMargins,
            bottom: layoutMargins,
            right: layoutMargins
        )
    }

    private func configureWeatherStackView() {
        let width = self.frame.height * 0.258
        weatherStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        weatherStackView.heightAnchor.constraint(
            equalTo: weatherStackView.widthAnchor).isActive = true
    }

    private func setupView() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { scrollView in
            scrollView.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { contentView in
            contentView.top.equalTo(scrollView.contentLayoutGuide)
            contentView.leading.trailing.bottom.centerX.equalToSuperview()
        }
    }

    private func configureView() {
        self.backgroundColor = .design(.mainBackground)
        self.contentView.axis = .vertical
        self.contentView.spacing = 15
    }

    private func setupContentView() {
        let weatherStackView = makeWeatherStackView()
        let todayLuckStackView = TodayLuckStackView()
        contentView.addArrangedSubviews(
            [titleStackView, routineCollectionView, weatherStackView, todayLuckStackView]
        )

        // MARK: color 관련. 추후 삭제
        routineCollectionView.backgroundColor = .blue
    }

    private func makeWeatherStackView() -> UIStackView {
        let emptyView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 20
            return view
        }()

        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.addArrangedSubviews([weatherStackView, emptyView])
            stackView.axis = .horizontal
            stackView.spacing = 13
            return stackView
        }()

        return stackView
    }

}
