//
//  ToDoCollectionViewLayout.swift
//  GoodMorning
//
//  Created by Sunny on 2023/10/06.
//

import UIKit

struct ToDoCollectionViewLayout {

    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.backgroundColor = .clear
            configuration.headerMode = .supplementary
            configuration.headerTopPadding = 10

            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 7
            section.contentInsets.top = 7

            return section
        }

        return layout
    }
}
