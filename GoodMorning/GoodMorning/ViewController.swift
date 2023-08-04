//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import SnapKit

private enum Section: Hashable {

    case main

}

private struct Item: Hashable {

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
            iconImage: UIImage(systemName: "headphones")!,
            description: "물 한잔 마시기", isChecked: false
        ),
        Item(
            iconImage: UIImage(systemName: "headphones")!,
            description: "집 청소하기", isChecked: false
        ),
        Item(
            iconImage: UIImage(systemName: "headphones")!,
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
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        configureContainerView()
        configureCollectionView()

    }

    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height).dividedBy(2.5)
        }
    }

    private func configureCollectionView() {

    }

}
