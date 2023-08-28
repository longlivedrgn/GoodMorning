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
                        """     // 추후 CoreData와 연결 예정
        textView.font = .pretendard(size: 18, weight: .semibold)
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
        setupTextView()
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
        self.navigationItem.leftBarButtonItem = deleteItem
        self.navigationItem.rightBarButtonItem = checkItem
    }

    private func setupTODOModal() {
        let totalStackView: UIStackView = {
            let stackView = UIStackView(frame: .zero)

            let titleStackView = makeTitleStackView()
            let priorityStackView = makePriorityLabelView()
            stackView.addArrangedSubviews([titleStackView, textView, priorityStackView])

            let spacing = view.frame.height * 0.035
            stackView.spacing = spacing
            stackView.axis = .vertical
            return stackView
        }()

        self.view.addSubview(totalStackView)
        let horizontalInset: CGFloat = self.view.frame.width * 0.046
        totalStackView.snp.makeConstraints { totalStackView in
            totalStackView.top.bottom.equalTo(view.safeAreaLayoutGuide)
            totalStackView.leading.trailing.equalToSuperview().inset(horizontalInset)
        }
    }

    private func makeTitleStackView() -> UIStackView {
        let emojiTextField: EmojiTextField = {
            let emoji = EmojiTextField()
            emoji.clipsToBounds = true
            emoji.delegate = self
            return emoji
        }()
        let width = self.view.frame.width * 0.1
        emojiTextField.snp.makeConstraints { emojiTextField in
            emojiTextField.width.equalTo(width)
        }

        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emojiTextField, titleTextField])
            stackView.spacing = 10
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
            let controlTopOffset: CGFloat = self.view.frame.height * 0.02
            let controlHeight: CGFloat = self.view.frame.height * 0.047
            let controlWidth: CGFloat = self.view.frame.width * 0.433
            prioritySegmentedControl.snp.makeConstraints { control in
                control.top.equalTo(label.snp.bottom).offset(controlTopOffset)
                control.leading.equalToSuperview()
                control.height.equalTo(controlHeight)
                control.width.equalTo(controlWidth)
            }

            return view
        }()

        return view
    }

    private func setupTextView() {
        let height = self.view.frame.height * 0.164
        self.textView.snp.makeConstraints { textView in
            textView.height.equalTo(height)
        }
    }

    @objc private func tappedDeleteButton() {
        print("delete button 눌림")
    }

    @objc private func tappedCheckButton() {
        print("check button 눌림")
    }

    @objc private func selectedPriority() {
        self.prioritySegmentedControl.selectedIndex = self.prioritySegmentedControl
            .selectedSegmentIndex
    }

}

extension TODOModalViewController: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.count == 0 {
            // 만약 이모티콘이 비었으면 기본값으로 설정.
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
