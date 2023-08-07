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
    let priority: Priority
    let identifier = UUID()

    static let allItems = [
        Item(
            iconImage: UIImage(systemName: "headphones") ?? UIImage(),
            description: "Swift 공부하기", isChecked: false, priority: .high
        ),
        Item(
            iconImage: UIImage(systemName: "sun.min") ?? UIImage(),
            description: "물 한잔 마시기", isChecked: false, priority: .high
        ),
        Item(
            iconImage: UIImage(systemName: "keyboard") ?? UIImage(),
            description: "집 청소하기", isChecked: false, priority: .medium
        ),
        Item(
            iconImage: UIImage(systemName: "figure.walk") ?? UIImage(),
            description: "야곰한테 전화하기", isChecked: false, priority: .low
        )
    ]

}

class ViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Item>
    private var backingStore: [Item] = Item.allItems
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
        applySnapShot()
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
            configuration.headerMode = .supplementary
            configuration.headerTopPadding = 15

            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 7
            section.contentInsets.top = 10

            return section
        }

        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TODOListCell, Item> {
            cell, indexPath, item in
            cell.updateWithItem(item)
            cell.accessories = [.delete(displayed: .whenEditing, actionHandler: {
                [weak self] in
                self?.delete(item)
            }), .reorder()]
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<TODOHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { supplementaryView, elementKind, indexPath in
            supplementaryView.delegate = self
        }

        datasource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: TODOCollectionView
        ) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }

        datasource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }

        configureReordering()
    }

    private func delete(_ item: Item) {
        guard let indexPath = datasource?.indexPath(for: item) else { return }
        backingStore.remove(at: indexPath.item)
        applySnapShot()
    }

    private func configureReordering() {
        datasource?.reorderingHandlers.canReorderItem = { item in return true }
        datasource?.reorderingHandlers.didReorder = { [weak self] transaction in
            if let updatedBackingStore = self?.backingStore.applying(transaction.difference) {
                self?.backingStore = updatedBackingStore
            }
        }
    }

    private func applySnapShot() {
        var snapShot = SnapShot()
        snapShot.appendSections([Section.main])

        let items = backingStore
        snapShot.appendItems(items, toSection: .main)

        datasource?.apply(snapShot)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        TODOCollectionView.isEditing = editing
    }

}

extension ViewController: TODOHeaderViewDelegate {

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didEditButtonTapped sender: UIButton) {
        TODOCollectionView.isEditing.toggle()
    }

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didPlusButtonTapped sender: UIButton) {
        print("plusbuttondidTapped!")
    }

}
