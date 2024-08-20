import UIKit
import SnapKit

class SelfieRecordCompleteViewController: UIViewController {
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PuzzleCheck1") // "기록 추가 완료" 이미지를 여기에 설정
        return imageView
    }()
    
    private lazy var completionLabel: UILabel = {
        let label = UILabel()
        label.text = "기록 추가 완료!"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = getCurrentDate() // 현재 날짜를 표시
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor(named: "Main")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(checkImageView)
        view.addSubview(completionLabel)
        view.addSubview(dateLabel)
        view.addSubview(doneButton)
        
        let superViewHeight = UIScreen.main.bounds.height
        
        checkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.4)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(checkImageView.snp.height).multipliedBy(checkImageView.image!.size.width / checkImageView.image!.size.height)
        }
        
        completionLabel.snp.makeConstraints { make in
            make.top.equalTo(checkImageView.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(completionLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(50)
        }
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: Date())
    }
    
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
