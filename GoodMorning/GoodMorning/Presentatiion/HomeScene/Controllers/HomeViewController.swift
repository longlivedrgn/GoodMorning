//
//  HomeViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import SnapKit

fileprivate func makeRepository() -> CurrentWeatherRepository {
    return DefaultCurrentWeatherRepository()
}

final class HomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    private var fetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase?
    private let weatherStackView = WeatherStackView(weather: .drizzle, temperature: 27)
    private let todayLuckStackView = TodayLuckStackView()
    private let titleStackView = DoubleLabelStackView(type: .title, nickName: "Miro")

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, TODOItem>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, TODOItem>
    private var backingStore: [TODOItem] = TODOItem.allItems
    private var datasource: DataSource?

    private lazy var routineCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionview.layer.cornerRadius = 30
        collectionview.isScrollEnabled = false
        collectionview.backgroundColor = .red

        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        fetchCurrentWeatherUseCase = DefaultFetchCurrentWeatherUseCase(
            currentWeatherRepository: makeRepository()
        )

        self.view.backgroundColor = .design(.mainBackground)

        configureContentView()
        configureRoutineCollectionView()
        configureWeatherStackView()
        configureConstraints()
        applySnapShot()
    }

    private func configureConstraints() {
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            scrollView.top.equalTo(view.snp.top)
        }
        self.contentView.snp.makeConstraints { contentView in
            contentView.top.equalTo(scrollView.contentLayoutGuide)
            contentView.leading.trailing.bottom.centerX.equalToSuperview()
        }
    }

    private func configureContentView() {
        self.contentView.axis = .vertical
        self.contentView.spacing = 15
        self.contentView.isLayoutMarginsRelativeArrangement = true

        let weatherStackView = makeWeatherStackView()
        self.contentView.addArrangedSubviews(
            [titleStackView, routineCollectionView, weatherStackView, todayLuckStackView]
        )

        let layoutMargins = self.view.frame.width * 0.058
        self.contentView.layoutMargins = .init(
            top: layoutMargins,
            left: layoutMargins,
            bottom: layoutMargins,
            right: layoutMargins
        )
    }

    private func configureRoutineCollectionView() {
        let height = self.view.frame.height * 0.350
        self.routineCollectionView.snp.makeConstraints { routineCollectionView in
            routineCollectionView.height.equalTo(height)
        }

        configureDataSource()
    }

    private func configureWeatherStackView() {
        let size = self.view.frame.height * 0.258
        self.weatherStackView.snp.makeConstraints { weatherStackView in
            weatherStackView.width.height.equalTo(size)
        }
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

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .supplementary
            configuration.headerTopPadding = 15
            configuration.backgroundColor = .white

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
            collectionView: routineCollectionView
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

    private func presentTODOModalScene() {
        let todoModalViewController = TODOModalViewController()

        present(UINavigationController(rootViewController: todoModalViewController), animated: true)
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

extension HomeViewController: TODOHeaderViewDelegate {

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didEditButtonTapped sender: UIButton) {
        routineCollectionView.isEditing.toggle()
    }

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didPlusButtonTapped sender: UIButton) {
        presentTODOModalScene()
    }

}

extension HomeViewController: CheckBoxButtonDelegate {

    func checkBoxButton(
        _ checkBoxButton: CheckBoxButton,
        didCheckBoxButtonTapped sender: UIButton
    ) {
        // button 이벤트 전달!
    }

}

extension HomeViewController {

    enum Section {
        case main
    }

}
