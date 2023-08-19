//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, TODOItem>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, TODOItem>
    private var backingStore: [TODOItem] = TODOItem.allItems
    private var datasource: DataSource?

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var TODOCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
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
        let cellRegistration = UICollectionView.CellRegistration<TODOListCell, TODOItem> {
            cell, indexPath, item in
            cell.updateWithItem(item)
            cell.configureDelegate(self)
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

        datasource = UICollectionViewDiffableDataSource<Section, TODOItem>(
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

        configureReorderingAccessory()
    }

    private func delete(_ item: TODOItem) {
        guard let indexPath = datasource?.indexPath(for: item) else { return }
        backingStore.remove(at: indexPath.item)
        applySnapShot()
    }

    private func configureReorderingAccessory() {
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

}

extension ViewController: TODOHeaderViewDelegate {

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didEditButtonTapped sender: UIButton) {
        TODOCollectionView.isEditing.toggle()
    }

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didPlusButtonTapped sender: UIButton) {
        print("plusbuttondidTapped!")
    }

}

extension ViewController: CheckBoxButtonDelegate {

    func checkBoxButton(
        _ checkBoxButton: CheckBoxButton,
        didCheckBoxButtonTapped sender: UIButton
    ) {
        // button 이벤트 전달!
    }

}

extension ViewController {

    enum Section {

        case main

    }
    
}
