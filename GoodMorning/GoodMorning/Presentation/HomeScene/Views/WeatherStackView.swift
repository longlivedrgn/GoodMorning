//
//  WeatherView.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/11.
//

import UIKit

final class WeatherStackView: UIStackView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(currentWeather: CurrentWeather?) {
        super.init(frame: .zero)

        self.setupWeatherView(currentWeather)
        self.configureWeatherView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.configureWeatherViewMargin()
        self.configureImageViewSize()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWeatherView(_ weather: CurrentWeather?) {
        guard let weather else { return }
        let temperature = weather.temperature
        let weatherCondition = weather.condition

        let temperatureLabel: UILabel = {
            let label = PretendardLabel(text: "\(temperature)", size: 40, weight: .regular)
            return label
        }()
        self.imageView.image = weatherCondition.image

        self.addArrangedSubviews([imageView, temperatureLabel])
    }

    private func configureWeatherView() {
        self.axis = .vertical
        self.spacing = 13
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        self.alignment = .center
    }

    private func configureWeatherViewMargin() {
        self.isLayoutMarginsRelativeArrangement = true
        let horizontalMargin: CGFloat = self.frame.height * 0.159
        let verticalMargin: CGFloat = self.frame.height * 0.114
        self.layoutMargins = .init(
            top: verticalMargin,
            left: horizontalMargin,
            bottom: verticalMargin,
            right: horizontalMargin
        )
    }

    private func configureImageViewSize() {
        let size = self.frame.height * 0.5

        self.imageView.snp.makeConstraints { make in
            make.height.width.equalTo(size)
        }
    }

}
