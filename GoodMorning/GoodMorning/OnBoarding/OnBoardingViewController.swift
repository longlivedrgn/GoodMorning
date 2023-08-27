//
//  OnBoardingViewController.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import UIKit

final class OnBoardingViewController: UIViewController {

    private let greetingStackView: UIStackView = {
        let greetingStackView = UIStackView()
        let helloLabel = PretendardLabel(
            text: "안녕하세요.",
            alignment: .left,
            size: 48,
            weight: .heavy
        )
        let goodMorningLabel = PretendardLabel(
            text: "좋은 아침입니다.",
            alignment: .left,
            size: 33,
            weight: .medium
        )
        let descriptionLabel = PretendardLabel(
            text: "굿모닝에서는 오늘의 운세 기능을 제공하고 있어요. 더 정확한 정보를 전달해 드리기 위해 아래와 같은 정보가 필요해요.",
            color: .lightGray,
            alignment: .left,
            size: 17,
            weight: .medium
        )
        descriptionLabel.numberOfLines = 0

        greetingStackView.addArrangedSubviews([helloLabel, goodMorningLabel, descriptionLabel])
        greetingStackView.axis = .vertical
        greetingStackView.spacing = 10

        return greetingStackView
    }()

    private lazy var userInputStackView: UIStackView = {
        let userInputStackView = UIStackView()
        userInputStackView.addArrangedSubviews([
            self.userNameStackView,
            self.birthDateStackView,
            self.genderStackView]
        )
        userInputStackView.axis = .vertical
        userInputStackView.spacing = 30

        return userInputStackView
    }()

    private lazy var userNameStackView: UserInformationStackView = {
        let userNameStackView = UserInformationStackView(
            title: "이름",
            subView: self.userNameTextField
        )

        return userNameStackView
    }()

    private lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.font = .pretendard(size: 20, weight: .bold)
        userNameTextField.layer.configureBorder(
            cornerRadius: 15,
            borderWidth: 2,
            borderColor: UIColor.design(.mainBackground)?.cgColor
        )
        userNameTextField.placeholder = "이름을 작성해주세요."
        userNameTextField.textAlignment = .center
        userNameTextField.delegate = self

        return userNameTextField
    }()

    private lazy var birthDateStackView: UserInformationStackView = {
        let birthDateStackView = UserInformationStackView(
            title: "생년월일",
            subView: self.birthDateTextField
        )

        return birthDateStackView
    }()

    private lazy var birthDateTextField: UITextField = {
        let birthDateTextField = UITextField()
        birthDateTextField.font = .pretendard(size: 20, weight: .bold)
        birthDateTextField.layer.cornerRadius = 10
        birthDateTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        birthDateTextField.inputView = self.birthDatePicker
        birthDateTextField.placeholder = "생년월일을 작성해주세요."
        birthDateTextField.textAlignment = .center

        return birthDateTextField
    }()

    private lazy var birthDatePicker: UIDatePicker = {
        let birthDatePicker = UIDatePicker()
        birthDatePicker.datePickerMode = .date
        birthDatePicker.preferredDatePickerStyle = .wheels
        birthDatePicker.addTarget(
            self,
            action: #selector(datePickerValueDidChanged),
            for: .valueChanged
        )

        return birthDatePicker
    }()

    private let genderStackView: UserInformationStackView = {
        let font = UIFont.pretendard(size: 20, weight: .medium)
        let segmentedControl = UISegmentedControl(items: ["여자", "남자"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        let genderStackView = UserInformationStackView(title: "성별", subView: segmentedControl)

        return genderStackView
    }()

    private let startGoodMorningButton: UIButton = {
        let startGoodMorningButton = UIButton()
        startGoodMorningButton.layer.cornerRadius = 15
        startGoodMorningButton.setTitle("굿모닝 시작하기", for: .normal)
        startGoodMorningButton.setTitleColor(.black, for: .normal)
        startGoodMorningButton.titleLabel?.font = .pretendard(size: 30, weight: .medium)
        startGoodMorningButton.backgroundColor = .design(.mainBackground)

        return startGoodMorningButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureSubViews()
        addKeyBoardObserver()
        setUpDatePickerToolBar()
    }

    private func configureSubViews() {
        self.view.addSubview(self.greetingStackView)
        self.view.addSubview(self.userInputStackView)
        self.view.addSubview(self.startGoodMorningButton)

        self.greetingStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        self.userInputStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.greaterThanOrEqualTo(self.greetingStackView.snp.bottom).offset(40)
        }

        self.userNameTextField.snp.makeConstraints { make in
            make.height.equalTo(self.userNameStackView.titleLabel.snp.height).multipliedBy(2.0)
        }

        self.birthDateTextField.snp.makeConstraints { make in
            make.height.equalTo(self.birthDateStackView.titleLabel.snp.height).multipliedBy(2.0)
        }

        self.startGoodMorningButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.userInputStackView)
            make.height.equalTo(self.genderStackView.snp.height)
            make.top.lessThanOrEqualTo(self.userInputStackView.snp.bottom).offset(100)
            make.top.greaterThanOrEqualTo(self.userInputStackView.snp.bottom).offset(30)
            make.bottom.greaterThanOrEqualTo(
                self.view.safeAreaLayoutGuide
            ).inset(30).priority(.high)
        }
    }

    private func setUpDatePickerToolBar() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.items = [space, doneButton]
        toolBar.sizeToFit()

        self.birthDateTextField.inputAccessoryView = toolBar
    }

    @objc private func doneButtonDidTapped(_ sender: UIBarButtonItem) {
        self.birthDateTextField.text = self.birthDatePicker.date.yearMonthDayFormat()
        self.birthDateTextField.resignFirstResponder()
    }

    @objc private func datePickerValueDidChanged(_ sender: UIDatePicker) {
        self.birthDateTextField.text = sender.date.yearMonthDayFormat()
    }

}

extension OnBoardingViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
