//
//  UserInfoViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 7/29/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    class PaddedTextField: UITextField {
        
        var padding: UIEdgeInsets
        
        init(padding: UIEdgeInsets) {
            self.padding = padding
            super.init(frame: .zero)
            setupDefaultStyle()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Adjusts the text position within the field
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        // Adjusts the text position during editing
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        // Adjusts the placeholder text position
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        // Method to setup the default style for the text field
        private func setupDefaultStyle() {
            self.borderStyle = .none
            self.layer.borderColor = UIColor(hex: "#D8D8D8").cgColor
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 5.0
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.1 // Shadow opacity (0.0 ~ 1.0)
            self.layer.shadowOffset = CGSize(width: 3, height: 3) // Shadow offset position
            self.layer.shadowRadius = 5.0
            self.backgroundColor = UIColor(hex: "#FFFFFF")
        }
        
        // Optional: Method to easily update the placeholder text
        func setPlaceholder(_ placeholder: String, color: UIColor = .lightGray) {
                self.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: color]
                )
            }
    }
    
    // UI 요소 선언
    let profileLabel = UILabel()
    let profileImageView = UIImageView()
    let nicknameTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let genderLabel = UILabel()
    let genderSegmentedControl = UISegmentedControl(items: ["남성", "여성"])
    let birthdateLabel = UILabel()
    let birthdateTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let birthdatePicker = UIDatePicker()
    let countryLabel = UILabel()
    let countryTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let startButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        // 뷰 설정 및 초기화
        setupViews()
        setupConstraints()
        
        // 기타 설정
        configureTapGestureForProfileImage()
        configureTapGestureForDismissingPicker()
        configureDatePicker()
    
        
    }
    
    func setupViews() {
        // 프로필 라벨 설정
        profileLabel.text = "PROFILE"
        profileLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        profileLabel.textColor = UIColor(hex: "#5833FF")
        
        // 프로필 이미지 설정
        profileImageView.image = UIImage(named: "profileCircle")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        // 나머지 UI 요소 설정
        nicknameTextField.setPlaceholder("사용할 닉네임을 입력해주세요")
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        genderLabel.text = "성별"
        
        genderSegmentedControl.selectedSegmentIndex = 1
        genderSegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        birthdateLabel.text = "생년월일"
        
        birthdateTextField.setPlaceholder( "YYYY/MM/DD")
        birthdateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        countryLabel.text = "국적"
        
        countryTextField.setPlaceholder("🇰🇷 대한민국", color: .black)
        countryTextField.isUserInteractionEnabled = false
        
        
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        startButton.isEnabled = false
        startButton.backgroundColor = UIColor(hex: "#D3D3D3")
        startButton.layer.cornerRadius = 8
        startButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        // 뷰에 추가
        view.addSubview(profileLabel)
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(genderLabel)
        view.addSubview(genderSegmentedControl)
        view.addSubview(birthdateLabel)
        view.addSubview(birthdateTextField)
        view.addSubview(countryLabel)
        view.addSubview(countryTextField)
        view.addSubview(startButton)
    }
    
    func setupConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.leading.equalTo(nicknameTextField)
        }
        
        genderSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(50)
        }
        
        birthdateLabel.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(nicknameTextField)
        }
        
        birthdateTextField.snp.makeConstraints { make in
            make.top.equalTo(birthdateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(50)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdateTextField.snp.bottom).offset(20)
            make.leading.equalTo(nicknameTextField)
            make.height.equalTo(50)
        }
        
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(50)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // 추가적인 기능 구현 (예: 프로필 이미지 선택, 생년월일 변경 등)
    
    func findViewController() -> UIViewController? {
            if let nextResponder = self.next as? UIViewController {
                return nextResponder
            } else if let nextResponder = self.next as? UIView {
                return nextResponder.findViewController()
            } else {
                return nil
            }
        }
    
    @objc func signUpButtonTapped() {
        let tabBarController = TabBar()
               tabBarController.modalPresentationStyle = .fullScreen
               present(tabBarController, animated: true, completion: nil)
    }
    
    func configureTapGestureForProfileImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }

    func configureTapGestureForDismissingPicker() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissDatePicker() {
        view.endEditing(true)
    }
    
    func configureDatePicker() {
        birthdatePicker.datePickerMode = .date
        birthdatePicker.preferredDatePickerStyle = .wheels
        birthdatePicker.maximumDate = Date()
        birthdatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        birthdateTextField.inputView = birthdatePicker
    }
    
    // 프로필 이미지 선택
    @objc func selectProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // 이미지 선택 완료 시 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    // 닉네임 또는 생년월일 변경 시 호출
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkFormValidity()
    }
    
    // 성별 선택 시 호출
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        checkFormValidity()
    }
    
    // 생년월일 변경 시 호출
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        birthdateTextField.text = dateFormatter.string(from: sender.date)
        checkFormValidity()
    }
    
    // 폼 유효성 검사
    func checkFormValidity() {
        let isFormValid = !(nicknameTextField.text?.isEmpty ?? true) &&
            !(birthdateTextField.text?.isEmpty ?? true) &&
            (genderSegmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment)
        
        startButton.isEnabled = isFormValid
        startButton.backgroundColor = isFormValid ? UIColor(hex: "#6744FF") : UIColor(hex: "#D3D3D3")
    }
}
