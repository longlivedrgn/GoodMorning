//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import SnapKit

enum Section: Hashable {

    case main

}

struct Item: Hashable {

    let iconImage: UIImage
    let description: String
    let isChecked: Bool
    let identifier = UUID()

    static let allItems = [
        Item(
            iconImage: UIImage(systemName: "headphones")!,
            description: "Swift 공부하기", isChecked: false
        ),
        Item(
            iconImage: UIImage(systemName: "sun.min")!,
            description: "물 한잔 마시기", isChecked: false
        ),
        Item(
            iconImage: UIImage(systemName: "keyboard")!,
            description: "집 청소하기", isChecked: false
        ),
        Item(
            iconImage: UIImage(systemName: "figure.walk")!,
            description: "야곰한테 전화하기", isChecked: false
        )
    ]

}

class ViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Item>
    private var datasource: DataSource?

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var TODOCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionview.backgroundColor = .green
        collectionview.layer.cornerRadius = 30
        collectionview.isScrollEnabled = false

        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        configureContainerView()
        configureCollectionView()
        configureDataSource()

    }

    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height).dividedBy(3)
        }
    }

    private func configureCollectionView() {
        containerView.addSubview(TODOCollectionView)
        TODOCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 5

            return section
        }

        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TODOListCell, Item> {
            cell, indexPath, item in
            cell.updateWithItem(item)
        }

        datasource = UICollectionViewDiffableDataSource<Section, Item> (
            collectionView: TODOCollectionView
        ) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }

        applySnapShot()
    }

    private func applySnapShot() {
        var snapShot = SnapShot()
        snapShot.appendSections([Section.main])

        let items = Item.allItems
        snapShot.appendItems(items, toSection: .main)

        datasource?.apply(snapShot)
    }

}
