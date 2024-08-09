//
//  MemoLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/2/24.
//

import UIKit
import SnapKit

class MemoLogViewController: UIViewController {

    //MARK: - UI
    private lazy var customNavBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행하면서 느낀 것들을 \n글로 표현해보세요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "subtitle")
        return label
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dum3")
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
        return stackView
    }()
    
    private lazy var memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor(named: "Black3")
        textView.text = "| 메모를 작성해주세요"
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.cornerRadius = 5
        textView.delegate = self
        return textView
    }()
        
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록 추가", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.addTarget(self, action: #selector(addRecord), for: .touchUpInside)
        return button
    }()

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()

        // NotificationCenter 관찰자 추가
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }

    //MARK: - Setup UI
    private func setupUI() {
        setupDismissKeyboardGesture()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleImageView)
        view.addSubview(addButton)
        
        view.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(memoTitleLabel)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        contentStackView.addArrangedSubview(memoTextView)
        contentStackView.addArrangedSubview(createSpacer(height: 232))
        contentStackView.addArrangedSubview(addButton)

        setConstraints()
    }
    
    private func createSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
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
        
        memoTextView.snp.makeConstraints { make in
            make.height.equalTo(191)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(50) // 원하는 버튼 높이
        }
    }
    
    //MARK: - Function
    
    private func updateAddButtonState() {
        addButton.isEnabled = memoTextView.text != "| 메모를 작성해주세요" && !memoTextView.text.isEmpty
        addButton.backgroundColor = memoTextView.text != "| 메모를 작성해주세요" && !memoTextView.text.isEmpty ? UIColor(named: "Main3") : UIColor(named: "Cancel")
    }
    
    ///뒤로가기 버튼
    @objc private func handleBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addRecord() {
        // 기록 추가 기능 구현
    }
    
    ///키보드 내리기
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
        
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Extension
extension MemoLogViewController: UITextViewDelegate, UINavigationControllerDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "| 메모를 작성해주세요" {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "| 메모를 작성해주세요"
            textView.textColor = UIColor(named: "Black3")
        }
        updateAddButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateAddButtonState()
    }
}