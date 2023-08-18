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
        return collectionView
    }()
    private let weatherStackView = WeatherStackView(weather: .drizzle, temperature: 27)

    init() {
        super.init(frame: .zero)

        self.setupView()
        self.configureView()
        self.setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.configureContentViewMargins()
        self.configureRoutineCollectionView()
        self.configureWeatherStackView()
    }

    private func configureContentViewMargins() {
        self.contentView.isLayoutMarginsRelativeArrangement = true

        let layoutMargins = self.frame.width * 0.058
        self.contentView.layoutMargins = .init(
            top: layoutMargins,
            left: layoutMargins,
            bottom: layoutMargins,
            right: layoutMargins
        )
    }

    private func configureRoutineCollectionView() {
        let height = self.frame.height * 0.304
        self.routineCollectionView.snp.makeConstraints { routineCollectionView in
            routineCollectionView.height.equalTo(height)
        }
    }

    private func configureWeatherStackView() {
        let size = self.frame.height * 0.258
        self.weatherStackView.snp.makeConstraints { weatherStackView in
            weatherStackView.width.height.equalTo(size)
        }
    }

    private func setupView() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        self.contentView.snp.makeConstraints { contentView in
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
        self.contentView.addArrangedSubviews(
            [titleStackView, routineCollectionView, weatherStackView, todayLuckStackView]
        )

        // MARK: color 관련. 추후 삭제
        self.routineCollectionView.backgroundColor = .blue
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
