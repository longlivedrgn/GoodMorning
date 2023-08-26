//
//  PrioritySegmentedControl.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/26.
//

import UIKit

final class PrioritySegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.removeBackgroundColor()
        self.configurePrioritySegmentedControl()
    }

    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func removeBackgroundColor() {
        let image = UIImage()

        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(
            image,
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }

    private func configurePrioritySegmentedControl() {
        self.selectedSegmentIndex = 0
    }

}
