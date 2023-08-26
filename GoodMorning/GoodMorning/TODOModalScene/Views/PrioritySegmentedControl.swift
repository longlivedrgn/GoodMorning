//
//  PrioritySegmentedControl.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/26.
//

import UIKit

final class PrioritySegmentedControl: UISegmentedControl {

    var selectedIndex: Int  = 0 {
        didSet {
            configurePrioritySegmentedControlImage()
        }
    }

    init() {
        let array = Priority.allCases.map { $0.rawValue.description }
        super.init(items: array)

        self.removeBackgroundColor()
        self.configurePrioritySegmentedControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configurePrioritySegmentedControlImage() {
        Priority.allCases.forEach { priority in
            if selectedIndex == priority.rawValue {
                super.setImage(
                    priority.image?.withRenderingMode(.alwaysOriginal),
                    forSegmentAt: selectedIndex
                )
            } else {
                super.setImage(
                    priority.image?.withAlpha(0.4).withRenderingMode(.alwaysOriginal),
                    forSegmentAt: priority.rawValue
                )
            }
        }
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
        configurePrioritySegmentedControlImage()
    }

}
