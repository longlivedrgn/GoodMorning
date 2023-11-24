//
//  HomeViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: Actions
    struct Actions {
        let showToDoModal: (ToDoItem?) -> Void
        let showWeatherDetailView: (CurrentWeather?) -> Void
    }

    var actions: Actions?

    // MARK: Properties(Datasource, CoreData, ViewModel)
    private var backingStore: [ToDoItem] = ToDoItem.allItems
    private var datasource: DataSource?
    private var viewModel: HomeSceneViewModel

    // MARK: Properties(Views)
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    private let titleStackView = DoubleLabelStackView(type: .title, nickName: "Miro")

    private lazy var TODOCollectionView: UICollectionView = {
        let collectionview = UICollectionView(
            frame: .zero,
            collectionViewLayout: ToDoCollectionViewLayout.createLayout()
        )
        collectionview.layer.cornerRadius = 30
        collectionview.isScrollEnabled = false
        collectionview.backgroundColor = .white

        return collectionview
    }()

    private let weatherStackView = WeatherStackView(currentWeather: nil)

    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    let weatherTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 13
        return stackView
    }()

    private let todayLuckStackView = TodayLuckStackView()

    // MARK: TapGesture
    lazy var weatherViewTapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(weatherViewDidTapped)
    )

    init(viewModel: HomeSceneViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureViews()
        configureDataSource()
        configureSupplementaryView()
        configureReorderingAccessory()
        applySnapShot()
    }

}

extension HomeViewController {

    private func configureViewModel() {
        self.bind(to: viewModel)
    }

    private func configureViews() {
        configureContentViewMargins()
        configureView()
        configureContentView()
        setupScrollView()
        setupContentView()
    }

    private func bind(to viewModel: HomeSceneViewModel) {
        viewModel.currentWeather.observe(on: self) { [weak self] currentWeather in
            DispatchQueue.main.async {
                self?.weatherStackView.setupWeatherView(currentWeather)
            }
        }
    }

    private func configureContentViewMargins() {
        self.contentView.isLayoutMarginsRelativeArrangement = true

        let layoutMargins = self.view.frame.width * 0.058
        self.contentView.layoutMargins = .init(
            top: layoutMargins,
            left: layoutMargins,
            bottom: layoutMargins,
            right: layoutMargins
        )
    }

    private func configureView() {
        self.view.backgroundColor = .design(.mainBackground)
        self.weatherStackView.addGestureRecognizer(weatherViewTapGesture)
    }

    private func configureContentView() {
        self.contentView.axis = .vertical
        self.contentView.spacing = 15
    }

    private func setupScrollView() {
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.top.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints { contentView in
            contentView.top.equalTo(scrollView.contentLayoutGuide)
            contentView.leading.trailing.bottom.centerX.equalToSuperview()
        }
    }

    private func setupContentView() {
        let height = self.view.frame.height * 0.32
        self.TODOCollectionView.snp.makeConstraints { todoCollectionView in
            todoCollectionView.height.equalTo(height)
        }

        let size = self.view.frame.height * 0.258
        self.weatherStackView.snp.makeConstraints { weatherStackView in
            weatherStackView.width.height.equalTo(size)
        }

        weatherTotalStackView.addArrangedSubviews([weatherStackView, emptyView])
        self.contentView.addArrangedSubviews(
            [titleStackView, TODOCollectionView, weatherTotalStackView, todayLuckStackView]
        )
    }

    private func configureDataSource() {
        let cellRegistration = CellRegistration {
            cell, indexPath, item in
            cell.updateWithItem(item)
            cell.configureDelegate(self)
            cell.accessories = [.delete(displayed: .whenEditing, actionHandler: { [weak self] in
                self?.delete(item)
            }), .reorder()]
        }

        datasource = UICollectionViewDiffableDataSource<Section, ToDoItem>(
            collectionView: TODOCollectionView
        ) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }

    private func configureSupplementaryView() {
        let headerRegistration = HeaderRegistration(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { supplementaryView, elementKind, indexPath in
            supplementaryView.delegate = self
        }

        datasource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }

    private func configureTODOModal() {
        let todoModalViewController = TODOModalViewController()

        present(UINavigationController(rootViewController: todoModalViewController), animated: true)
    }

    private func delete(_ item: ToDoItem) {
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

// MARK: Functions - CheckBoxButtonDelegate
extension HomeViewController: CheckBoxButtonDelegate {

    func checkBoxButton(
        _ checkBoxButton: CheckBoxButton,
        didCheckBoxButtonTapped sender: UIButton
    ) {
        // button 이벤트 전달!
    }

}

// MARK: Functions - TODOHeaderViewDelegate
extension HomeViewController: TODOHeaderViewDelegate {

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didEditButtonTapped sender: UIButton) {
        TODOCollectionView.isEditing.toggle()
    }

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didPlusButtonTapped sender: UIButton) {
        print("plusbuttondidTapped!")
    }

}

// MARK: @objc functions
extension HomeViewController {

    @objc private func weatherViewDidTapped() {
        self.actions?.showWeatherDetailView(viewModel.currentWeather.value)
    }

}

extension HomeViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ToDoItem>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, ToDoItem>

    private typealias CellRegistration = UICollectionView.CellRegistration<TODOListCell, ToDoItem>
    private typealias HeaderRegistration =
        UICollectionView.SupplementaryRegistration<TODOHeaderView>

    enum Section {

        case main

    }

}
