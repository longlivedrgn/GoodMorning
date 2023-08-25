//
//  OnBoardingViewController.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/24.
//

import UIKit

final class OnBoardingViewController: UIViewController {

    // MARK: guard 문으로 가져오는 거 해결하기!~!~!~!
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

        greetingStackView.addArrangedSubviews([helloLabel, goodMorningLabel, descriptionLabel]
        )
        greetingStackView.axis = .vertical
        greetingStackView.spacing = 10

        return greetingStackView
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

    private lazy var userNameStackView: UserInformationStackView = {
        let userNameTextField = UITextField()
        userNameTextField.layer.configureBorder(
            borderWidth: 2,
            borderColor: UIColor.design(.mainBackground)?.cgColor
        )
        userNameTextField.placeholder = "이름을 작성해주세요."
        userNameTextField.textAlignment = .center
        userNameTextField.delegate = self
        userNameTextField.font = .pretendard(size: 30, weight: .medium)

        let userNameStackView = UserInformationStackView(title: "이름", subView: userNameTextField)

        return userNameStackView
    }()

    private lazy var birthDateStackView: UserInformationStackView = {
        let birthDatePicker = UIDatePicker()
        birthDatePicker.datePickerMode = .date
        birthDatePicker.preferredDatePickerStyle = .wheels
        birthDatePicker.addTarget(
            self,
            action: #selector(datePickerValueDidChanged),
            for: .valueChanged
        )

        let birthDateTextField = UITextField()
        birthDateTextField.font = .pretendard(size: 20, weight: .medium)
        birthDateTextField.layer.cornerRadius = 10
        birthDateTextField.backgroundColor = .lightGray
        birthDateTextField.inputView = birthDatePicker
        birthDateTextField.placeholder = "생년월일을 작성해주세요."
        birthDateTextField.textAlignment = .center

        let birthDateStackView = UserInformationStackView(
            title: "생년월일",
            subView: birthDateTextField
        )

        return birthDateStackView
    }()

    private let genderStackView: UserInformationStackView = {
        let segmentControl = UISegmentedControl(items: ["여자", "남자"])
        segmentControl.selectedSegmentIndex = 0
        let genderStackView = UserInformationStackView(title: "성별", subView: segmentControl)

        return genderStackView
    }()

    private lazy var userInputStackView: UIStackView = {
        let userInputStackView = UIStackView()

        userInputStackView.addArrangedSubviews([
            userNameStackView,
            birthDateStackView,
            genderStackView]
        )
        userInputStackView.axis = .vertical
        userInputStackView.spacing = 20

        return userInputStackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(greetingStackView)
        view.addSubview(userInputStackView)
        view.addSubview(startGoodMorningButton)
        setUpDatePickerToolBar()

        greetingStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        userInputStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(greetingStackView.snp.bottom).offset(40)
        }

        startGoodMorningButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(userInputStackView)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }

    @objc private func datePickerValueDidChanged(_ sender: UIDatePicker) {
        guard let textField = birthDateStackView.arrangedSubviews[1] as? UITextField else { return }
        textField.text = sender.date.yearMonthDayFormat()
    }

    private func setUpDatePickerToolBar() {
        let toolBar = UIToolbar()

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )

        toolBar.items = [space, doneButton]
        toolBar.sizeToFit()

        guard let textField = birthDateStackView.arrangedSubviews[1] as? UITextField else { return }
        textField.inputAccessoryView = toolBar
    }

    @objc private func doneButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let textField = birthDateStackView.arrangedSubviews[1] as? UITextField else { return }
        guard let datePicker = textField.inputView as? UIDatePicker else { return }

        textField.text = datePicker.date.yearMonthDayFormat()
        textField.resignFirstResponder()
    }

}

extension OnBoardingViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
