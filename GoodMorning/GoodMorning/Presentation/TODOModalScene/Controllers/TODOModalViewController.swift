//
//  ToDoModalViewController.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/25.
//

import UIKit

final class ToDoModalViewController: UIViewController {

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .pretendard(size: 30, weight: .bold)
        textField.placeholder = "모닝 루틴"
        return textField
    }()

    private let emojiTextField: EmojiTextField = {
        let emoji = EmojiTextField()
        emoji.placeholder = "😀"
        emoji.clipsToBounds = true
        return emoji
    }()

    private let textViewPlaceHolder = "모닝 루틴 설명을 입력하세요."
    private let textView: UITextView = {
        let textView = UITextView()
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

    let priorityView: UIView = {
        let view = UIView()
        return view
    }()

    let priorityLabel: UILabel = {
        let label = PretendardLabel(text: "중요도", size: 15, weight: .semibold)
        label.textColor = .black.withAlphaComponent(0.7)
        return label
    }()

    private let viewModel: ToDoModalViewModel

    init(viewModel: ToDoModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTODOModal()
        configureNavigationBar()
        setupTODOModal()
        setupTextView()
        setupPriorityView()

        binding()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: Functions - public
extension ToDoModalViewController {

    func configureToDoItem(_ item: ToDoItem?) {
        self.viewModel.configureItem(item)
    }

}

// MARK: Functions - private
extension ToDoModalViewController {

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
            action: #selector(deleteButtonDidTap)
        )
        deleteItem.tintColor = .black
        let checkItem = UIBarButtonItem(
            image: .SFSymbol(.check),
            style: .plain,
            target: self,
            action: #selector(checkButtonDidTap)
        )
        checkItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = deleteItem
        self.navigationItem.rightBarButtonItem = checkItem
    }

    private func setupTODOModal() {
        let totalStackView: UIStackView = {
            let stackView = UIStackView(frame: .zero)

            let titleStackView = makeTitleStackView()
            stackView.addArrangedSubviews([titleStackView, textView, priorityView])

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
        self.emojiTextField.delegate = self

        let width = self.view.frame.width * 0.1
        self.emojiTextField.snp.makeConstraints { emojiTextField in
            emojiTextField.width.equalTo(width)
        }

        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emojiTextField, titleTextField])
            stackView.spacing = 10
            return stackView
        }()

        return stackView
    }

    private func setupPriorityView() {
        priorityView.addSubview(priorityLabel)
        priorityLabel.snp.makeConstraints { label in
            label.leading.top.equalToSuperview()
        }

        priorityView.addSubview(questionButton)
        questionButton.snp.makeConstraints { questionButton in
            questionButton.leading.equalTo(priorityLabel.snp.trailing).offset(4)
            questionButton.top.equalToSuperview()
            questionButton.centerY.equalTo(priorityLabel.snp.centerY)
        }

        priorityView.addSubview(prioritySegmentedControl)
        let controlTopOffset: CGFloat = self.view.frame.height * 0.02
        let controlHeight: CGFloat = self.view.frame.height * 0.047
        let controlWidth: CGFloat = self.view.frame.width * 0.433
        prioritySegmentedControl.snp.makeConstraints { control in
            control.top.equalTo(priorityLabel.snp.bottom).offset(controlTopOffset)
            control.leading.equalToSuperview()
            control.height.equalTo(controlHeight)
            control.width.equalTo(controlWidth)
        }
    }

    private func setupTextView() {
        self.textView.delegate = self

        let height = self.view.frame.height * 0.164
        self.textView.snp.makeConstraints { textView in
            textView.height.equalTo(height)
        }
    }

    private func binding() {
        self.viewModel.title.observe(on: self) { [weak self] title in
            self?.titleTextField.text = title
        }

        self.viewModel.description.observe(on: self) { [weak self] text in
            guard let text = text else {
                self?.setupTextViewPlaceHolder()
                return
            }
            self?.textView.text = text
        }

        self.viewModel.priority.observe(on: self) { [weak self] priority in
            self?.prioritySegmentedControl.selectedIndex = priority
        }

        self.viewModel.icon.observe(on: self) { [weak self] icon in
            self?.emojiTextField.text = icon
        }
    }

    private func setupTextViewPlaceHolder() {
        self.textView.text = self.textViewPlaceHolder
        self.textView.textColor = .lightGray
    }

}

// MARK: Functions - @objc
extension ToDoModalViewController {

    @objc private func deleteButtonDidTap() {
        self.viewModel.deleteItem()
        
        self.dismiss(animated: true)
    }

    @objc private func checkButtonDidTap() {
        self.viewModel.updateItem(
            title: titleTextField.text,
            description: textView.text,
            icon: emojiTextField.text,
            priority: prioritySegmentedControl.selectedIndex
        )

        self.dismiss(animated: true)
    }

    @objc private func selectedPriority() {
        self.prioritySegmentedControl.selectedIndex = self.prioritySegmentedControl
            .selectedSegmentIndex
    }

}

extension ToDoModalViewController: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string.count == 0 {
            return false
        } else {
            guard Character(string).isEmoji else { return false }
            textField.text = string
            return false
        }
    }

}

extension ToDoModalViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.setupTextViewPlaceHolder()
        }
    }

}
