//
//  TODOModalViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/25.
//

import UIKit

final class TODOModalViewController: UIViewController {

    private let titleTextField: UITextField = {
        let textField = UITextField()
//        textField.leftViewMode = .always
//        textField.leftView = emojiView

        textField.font = .pretendard(size: 30, weight: .semibold)
        textField.text = "Swift 공부하기"   // 추후 CoreData와 연결 예정
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTODOModal()
        configureNavigationBar()
        setupTODOModal()
    }

    private func configureTODOModal() {
        self.view.backgroundColor = .systemBackground

        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
        }
    }

    private func configureNavigationBar() {
        let deleteItem = UIBarButtonItem(
            image: .SFSymbol(.trash),
            style: .plain,
            target: self,
            action: #selector(tappedDeleteButton)
        )
        let checkItem = UIBarButtonItem(
            image: .SFSymbol(.check),
            style: .plain,
            target: self,
            action: #selector(tappedCheckButton)
        )
        // MARK: 추후 색상 변경
        self.navigationItem.leftBarButtonItem = deleteItem
        self.navigationItem.rightBarButtonItem = checkItem
    }

    private func setupTODOModal() {
        let totalStackView: UIStackView = {
            let stackView = UIStackView(frame: .zero)

            let titleStackView = makeTitleStackView()
            stackView.addArrangedSubviews([titleStackView])

            // MARK: 추후 삭제
            stackView.backgroundColor = .yellow
            return stackView
        }()

        view.addSubview(totalStackView)
        totalStackView.snp.makeConstraints { totalStackView in
            totalStackView.top.bottom.equalTo(view.safeAreaLayoutGuide)
            totalStackView.leading.trailing.equalToSuperview().inset(18)
        }
    }

    private func makeTitleStackView() -> UIStackView {

        // MARK: 추후 TextField로 변경 예정
        let emojiView = UIView()
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        emojiView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emojiView.backgroundColor = .systemPink

        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emojiView, titleTextField])
            stackView.spacing = 20
            stackView.alignment = .center
            return stackView
        }()

        return stackView
    }

    @objc private func tappedDeleteButton() {
        print("delete button 눌림")
    }

    @objc private func tappedCheckButton() {
        print("check button 눌림")
    }
}
