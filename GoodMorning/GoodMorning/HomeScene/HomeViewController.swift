//
//  HomeViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/07/07.
//

import UIKit

final class HomeViewController: UIViewController {

    private let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        self.view = homeView
    }

}
