//
//  EmojiCompleteViewController.swift
//  MyWorldApp
//
//  Created by 반성준 on 8/21/24.
//

import UIKit

class EmojiCompleteViewController: UIViewController {
    
    // 체크 이미지 (기록 완료 이미지)
    private lazy var emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puzzleCheck4") // 이모지 이미지를 여기에 설정
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // "기록 추가 완료" 라벨
    private lazy var completionLabel: UILabel = {
        let label = UILabel()
        label.text = "기록 추가 완료!"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = UIColor.systemPink
        return label
    }()
    
    // 현재 날짜를 표시하는 라벨
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = getCurrentDate() // 현재 날짜를 가져와 표시
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    // 미리보기 텍스트 라벨
    private lazy var previewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "이땐 이랬어요 :)"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    // 이모지 미리보기 라벨
    private lazy var emojiPreviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    // 완료 버튼
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor.systemPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(emojiImageView)
        view.addSubview(completionLabel)
        view.addSubview(dateLabel)
        view.addSubview(previewTextLabel)
        view.addSubview(emojiPreviewLabel)
        view.addSubview(doneButton)
        
        emojiImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100) // 이미지 크기 조정
        }
        
        completionLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(completionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        previewTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        emojiPreviewLabel.snp.makeConstraints { make in
            make.top.equalTo(previewTextLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // 현재 날짜를 가져오는 메서드
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: Date())
    }
    
    // 미리보기 텍스트 설정 메서드
    func setPreviewText(_ memoText: String, emojis: [String?]) {
        emojiPreviewLabel.text = emojis.compactMap { $0 }.joined(separator: " ")
    }
    
    // 완료 버튼을 눌렀을 때 동작
    @objc private func doneButtonTapped() {
        // 모든 모달을 닫고 루트 뷰인 탭바로 이동
        var targetViewController = presentingViewController
        
        // MemoLogViewController와 RecordCompleteViewController를 모두 dismiss
        while let presentingVC = targetViewController?.presentingViewController {
            targetViewController = presentingVC
        }
        
        targetViewController?.dismiss(animated: true) {
            if let tabBarController = UIApplication.shared.windows.first?.rootViewController as? TabBar {
                tabBarController.selectedIndex = 1 // "나의 기록" 탭으로 이동
            }
        }
    }
}
