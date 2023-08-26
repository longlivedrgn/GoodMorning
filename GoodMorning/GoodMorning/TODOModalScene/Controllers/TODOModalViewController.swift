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
        textField.font = .pretendard(size: 30, weight: .bold)
        textField.text = "Swift 공부하기"   // 추후 CoreData와 연결 예정
        return textField
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = """
                        추상 클래스는 하나 이상의 추상 메서드(구현이 없는 메서드)를 포함할 수 있는 클래스입니다.
                        객체 생성이 불가능하며, 이 클래스를 상속받은 자식 클래스에서 추상 메서드를 구현해야 합니다.
                        추상 클래스는 일반적으로 객체들 간의 공통된 특성을 정의하는데 사용됩니다.
                        """
        textView.font = .pretendard(size: 18, weight: .semibold)
        textView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        return textView
    }()

    private let questionButton: UIButton = {
        let button = UIButton()
        button.setImage(.SFSymbol(.question), for: .normal)
        button.tintColor = .black.withAlphaComponent(0.7)
        return button
    }()

    private lazy var prioritySegmentedControl: PrioritySegmentedControl = {
        let segmentedControl = PrioritySegmentedControl()
        segmentedControl.addTarget(self, action: #selector(selectedPriority), for: .valueChanged)
        return segmentedControl
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
        deleteItem.tintColor = .black
        let checkItem = UIBarButtonItem(
            image: .SFSymbol(.check),
            style: .plain,
            target: self,
            action: #selector(tappedCheckButton)
        )
        checkItem.tintColor = .black
        // MARK: 추후 색상 변경
        self.navigationItem.leftBarButtonItem = deleteItem
        self.navigationItem.rightBarButtonItem = checkItem
    }

    private func setupTODOModal() {
        let totalStackView: UIStackView = {
            let stackView = UIStackView(frame: .zero)

            let titleStackView = makeTitleStackView()
            let priorityStackView = makePriorityLabelView()
            stackView.addArrangedSubviews([titleStackView, textView, priorityStackView])

            stackView.spacing = 30
            stackView.axis = .vertical
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
        let emojiTextField: EmojiTextField = {
            let emoji = EmojiTextField()
            emoji.widthAnchor.constraint(equalToConstant: 40).isActive = true
            emoji.clipsToBounds = true
//            emoji.backgroundColor = .systemPink
            emoji.delegate = self
            return emoji
        }()

        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emojiTextField, titleTextField])
            stackView.spacing = 10
//            stackView.backgroundColor = .gray
            return stackView
        }()

        return stackView
    }

    private func makePriorityLabelView() -> UIView {
        let label: UILabel = {
            let label = PretendardLabel(text: "중요도", size: 15, weight: .semibold)
            label.textColor = .black.withAlphaComponent(0.7)
            return label
        }()

        let view: UIView = {
            let view = UIView()
            view.addSubview(label)
            label.snp.makeConstraints { label in
                label.leading.top.equalToSuperview()
            }

            view.addSubview(questionButton)
            questionButton.snp.makeConstraints { questionButton in
                questionButton.leading.equalTo(label.snp.trailing).offset(4)
                questionButton.top.equalToSuperview()
                questionButton.centerY.equalTo(label.snp.centerY)
            }

            view.addSubview(prioritySegmentedControl)
            prioritySegmentedControl.snp.makeConstraints { control in
                control.top.equalTo(label.snp.bottom).offset(17)
                control.leading.equalToSuperview()
                control.height.equalTo(40)
                control.width.equalTo(170)
            }

            return view
        }()

        return view
    }

    @objc private func tappedDeleteButton() {
        print("delete button 눌림")
    }

    @objc private func tappedCheckButton() {
        print("check button 눌림")
    }

    @objc private func selectedPriority() {
        prioritySegmentedControl.selectedIndex = prioritySegmentedControl.selectedSegmentIndex
    }

}

extension TODOModalViewController: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.count == 0 {
            textField.text = "😀"
            return false
        }

        if string.count > 0 {
            textField.text = string
            return false
        }

        return true
    }

}
