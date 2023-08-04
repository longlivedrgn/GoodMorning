//
//  ViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit
import CoreLocation

private enum Section: Hashable {

    case main

}

private struct Item: Hashable {

    let iconImage: UIImage
    let description: String
    let isChecked: Bool
    let identifier = UUID()

    static let allItems = [
        Item(iconImage: UIImage(systemName: "headphones")!, description: "Swift 공부하기", isChecked: false),
        Item(iconImage: UIImage(systemName: "headphones")!, description: "물 한잔 마시기", isChecked: false),
        Item(iconImage: UIImage(systemName: "headphones")!, description: "집 청소하기", isChecked: false),
        Item(iconImage: UIImage(systemName: "headphones")!, description: "야곰한테 전화하기", isChecked: false)
    ]

}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
