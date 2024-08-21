//
//  EmojiLogViewController.swift
//  MyWorldApp
//
//  Created by 반성준 on 8/21/24.
//

import UIKit
import SnapKit

class EmojiLogViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var travelId: Int
            
        init(travelId: Int) {
            self.travelId = travelId
            super.init(nibName: nil, bundle: nil)
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private lazy var customNavBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 기분인가요?"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 느끼는 감정을 \n4가지 이모지로 표현해 보세요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "subtitle")
        return label
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmojiLog")
        return imageView
    }()
    
    ///회색 배경부분부터
    private lazy var grayBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BgColor2")
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    // 선택된 이모지
    private var selectedEmojis: [String?] = [nil, nil, nil, nil]
    
    // 이모지 선택 공간을 위한 버튼 배열
    private var emojiButtons: [UIButton] = []
    
    // 이모지 밑줄을 위한 배열
    private var underlineViews: [UIView] = []
    
    let emojiLabel = UILabel()
    let emojiStackView = UIStackView()
    let memoLabel = UILabel()
    
    // 숨겨진 텍스트 필드 (이모지를 선택하기 위한)
    private var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default // 기본 키보드 (이모지 키보드를 활성화하기 위해)
        textField.isHidden = true // 숨김 상태
        return textField
    }()
    
    // 메모 텍스트 필드
    private lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "| 감정을 글로 표현해보세요 (30자 이내)"
        textView.textColor = .lightGray
        textView.delegate = self
        return textView
    }()
    
    // 기록 추가 버튼
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록 추가", for: .normal)
        button.backgroundColor = UIColor(hex: "D3D3D3")
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.addTarget(self, action: #selector(addRecord), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        setupDismissKeyboardGesture()
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()
        setConstraints()
        // 숨겨진 텍스트 필드를 뷰에 추가
        view.addSubview(hiddenTextField)
        hiddenTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // 이모지 라벨
        emojiLabel.text = "이모지"
        emojiLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        // 이모지 선택 버튼들 추가
        emojiStackView.axis = .horizontal
        emojiStackView.distribution = .fillEqually
        emojiStackView.spacing = 10
        
        memoLabel.text = "메모"
        memoLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal) // 빈 공간에 밑줄만
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            button.tag = i
            button.addTarget(self, action: #selector(selectEmoji(_:)), for: .touchUpInside)
            emojiButtons.append(button)
            
            let underline = UIView()
            underline.backgroundColor = .lightGray // 기본 회색
            underlineViews.append(underline)
            
            let containerView = UIView()
            containerView.addSubview(button)
            containerView.addSubview(underline)
            emojiStackView.addArrangedSubview(containerView)
            
            button.snp.makeConstraints { make in
                make.centerX.equalTo(containerView)
                make.centerY.equalTo(containerView)
            }
            
            underline.snp.makeConstraints { make in
                make.top.equalTo(button.snp.bottom).offset(5)
                make.centerX.equalTo(containerView)
                make.height.equalTo(2)
                make.width.equalTo(40)
            }
        }
        
        // 메모 텍스트 필드 및 기록 추가 버튼 추가
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleImageView)
        
        view.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(contentStackView)
        contentStackView.addSubview(emojiLabel)
        contentStackView.addSubview(emojiStackView)
        contentStackView.addSubview(memoLabel)
        contentStackView.addSubview(memoTextView)
        
        view.addSubview(addButton)
    }
    
    func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(customNavBar.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(21)
        }
        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(customNavBar.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(21)
            make.height.greaterThanOrEqualTo(42)
        }
        titleImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(129)
            make.width.height.equalTo(85)
            make.trailing.equalToSuperview().inset(21.18)
        }
        grayBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(grayBackgroundView.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        emojiLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        emojiStackView.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Function
    @objc private func handleBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    // 이모지 선택 액션
    @objc private func selectEmoji(_ sender: UIButton) {
        // 텍스트 필드 세션을 안전하게 관리합니다.
        if hiddenTextField.isFirstResponder {
            hiddenTextField.resignFirstResponder() // 활성화된 경우 먼저 비활성화
        }
        // 선택된 버튼의 태그를 텍스트 필드에 전달
        hiddenTextField.tag = sender.tag
        // 기본 키보드로 설정 (이모지를 입력할 수 있도록)
        hiddenTextField.keyboardType = .default
        // 텍스트 필드를 활성화하여 키보드를 띄웁니다.
        hiddenTextField.becomeFirstResponder()
    }
    
    // 이모지 선택 후 처리
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return false }
        
        // 이모지 입력 여부를 확인
        if string.unicodeScalars.first?.properties.isEmoji == true {
            let buttonTag = textField.tag
            selectedEmojis[buttonTag] = string
            emojiButtons[buttonTag].setTitle(string, for: .normal)
            underlineViews[buttonTag].backgroundColor = .systemRed // 선택한 이모지 밑줄을 빨간색으로 변경
            
            // 입력이 끝나면 텍스트 필드를 숨김
            hiddenTextField.resignFirstResponder()
            return false
        }
        
        return false // 이모지가 아닌 다른 문자는 막음
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 30 // Limit to 30 characters
    }
    
    // 기록 추가 액션
    @objc private func addRecord() {
        guard let memoText = memoTextView.text, memoText != "감정을 글로 표현해보세요 (30자 이내)", !memoText.isEmpty else {
            print("메모를 입력하세요.")
            return
        }
        // 여기서 기록을 서버에 저장하거나 다음 화면으로 이동하는 로직을 구현하면 됩니다.
        print("이모지: \(selectedEmojis)")
        print("메모: \(memoText)")
        
        // 확인 화면으로 이동 예시
        let completionVC = EmojiCompleteViewController()
        completionVC.setPreviewText(memoText, emojis: selectedEmojis)
        self.navigationController?.pushViewController(completionVC, animated: true)
    }
    
    // UITextViewDelegate 메서드
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "| 감정을 글로 표현해보세요 (30자 이내)"
            textView.textColor = .lightGray
        }
    }
}
