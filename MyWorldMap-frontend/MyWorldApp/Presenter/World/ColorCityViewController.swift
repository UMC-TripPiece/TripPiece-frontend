//
//  SelectedCityViewController.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/14/24.
//

import UIKit
import Alamofire

class ColorCityViewController: UIViewController {
    
    var cityData: [String: String]? // 받아올 도시 정보
    

    
    // MARK: - UI View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    
    // 오른쪽 위 'X'자 버튼
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dismissButton"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button.heightAnchor.constraint(equalToConstant: 14).isActive = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    private let countryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Black5")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25 // 이미지뷰의 크기에 맞춰 반지름을 설정해야 함
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🇻🇳"  // 원하는 이모티콘 텍스트 설정
        label.font = UIFont.systemFont(ofSize: 32) // 레이블의 폰트 크기 조정
        label.textAlignment = .center
        return label
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "하노이, 베트남"
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    private let colorSelectBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        return view
    }()
    
    
    // color selection description label
    private let colorSelectDescriptionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .leading
        
        let firstLabel: UILabel = {
            let label = UILabel()
            label.text = "색상 선택"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1)
            return label
        }()

        let secondLabel: UILabel = {
            let label = UILabel()
            label.text = "색상은 나라 전체에 반영됩니다."
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(named: "Black2")
            return label
        }()

        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        
        return stackView
    }()
    
    
    
    
    // 현재 선택된 버튼을 추적하는 변수
    private var selectedButton: UIButton? {
        didSet {
            // selectedButton이 설정될 때마다 saveButton의 상태를 업데이트
            saveButton.isEnabled = (selectedButton != nil)
        }
    }
    
    

    private lazy var colorSelectionButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let purpleButton = createButton(imageName: "Puzzle1", target: self, action: #selector(didTapButton(_:)))
        purpleButton.accessibilityIdentifier = "6744FF"
        let orangeButton = createButton(imageName: "Puzzle2", target: self, action: #selector(didTapButton(_:)))
        orangeButton.accessibilityIdentifier = "FFB40F"
        let greenButton = createButton(imageName: "Puzzle3", target: self, action: #selector(didTapButton(_:)))
        greenButton.accessibilityIdentifier = "25CEC1"
        let pinkButton = createButton(imageName: "Puzzle4", target: self, action: #selector(didTapButton(_:)))
        pinkButton.accessibilityIdentifier = "FD2D69"
        let addButton = createButton(imageName: "addButton", target: self, action: #selector(didTapAddButton(_:)), buttonImageSize: CGSize(width: 16, height: 16))
        addButton.accessibilityIdentifier = "addButton"

        
  
        
        stackView.addArrangedSubview(purpleButton)
        stackView.addArrangedSubview(orangeButton)
        stackView.addArrangedSubview(greenButton)
        stackView.addArrangedSubview(pinkButton)
        stackView.addArrangedSubview(addButton)

        
        return stackView
    }()
    
    
    
    // 공통된 UIButton 생성 함수
    private func createButton(imageName: String, target: Any?, action: Selector, buttonImageSize: CGSize = CGSize(width: 38, height: 38)) -> UIButton {
        let button = UIButton()
        
        // 이미지를 리사이즈하고 설정
        if let image = UIImage(named: imageName) {
            let resizedImage = image.resized(to: CGSize(width: buttonImageSize.width, height: buttonImageSize.height))
            button.setImage(resizedImage, for: .normal)
        }
        
        // Auto Layout 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 54).isActive = true
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
    
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.1)
        button.setTitleColor(UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        // 비활성화 상태일 때
        button.setTitleColor(.lightGray, for: .disabled)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // 활성화 상태일 때
        button.backgroundColor = UIColor(named: "Main")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        
        return stackView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        saveButton.isEnabled = false // 기본적으로 비활성화
        
        if let cityData = cityData {
            titleLabel.text = "\(cityData["cityName"] ?? ""), \(cityData["countryName"] ?? "")"
            emojiLabel.text = cityData["countryImage"]
        }
        
        uiAddSubViews()
        setupConstraints()
        
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        
        
    }
    
    
    
    private func uiAddSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(dismissButton)
        containerView.addSubview(countryImage)
        countryImage.addSubview(emojiLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(colorSelectBackgroundView)
        containerView.addSubview(colorSelectDescriptionStack)
        containerView.addSubview(colorSelectionButtonStack)
        containerView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(saveButton)
        containerView.addSubview(dismissButton)
    }
    
    

    
    

    
    // MARK: - Constraints
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        colorSelectBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        colorSelectDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        colorSelectionButtonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        

        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 348),
            containerView.heightAnchor.constraint(equalToConstant: 333),
            
            //dismissButton constraints
            dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            //country image
            countryImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 34),
            countryImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryImage.widthAnchor.constraint(equalToConstant: 51),
            countryImage.heightAnchor.constraint(equalToConstant: 51),
            
            emojiLabel.centerXAnchor.constraint(equalTo: countryImage.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: countryImage.centerYAnchor),
            
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: countryImage.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            
            // Color Selection view constraints
            colorSelectBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            colorSelectBackgroundView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -13),
            colorSelectBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            colorSelectBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            colorSelectDescriptionStack.topAnchor.constraint(equalTo: colorSelectBackgroundView.topAnchor, constant: 10),
            colorSelectDescriptionStack.leadingAnchor.constraint(equalTo: colorSelectBackgroundView.leadingAnchor, constant: 15),
            
            
            // Color selection view constraints
            colorSelectionButtonStack.bottomAnchor.constraint(equalTo: colorSelectBackgroundView.bottomAnchor, constant: -20),
            colorSelectionButtonStack.centerXAnchor.constraint(equalTo: colorSelectBackgroundView.centerXAnchor),
            
            
            // Cancel and done button constraints
            buttonsStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 325),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)

        ])
    }
    
    
    
    // MARK: - Functions
    
    
    
    @objc func didTapButton(_ sender: UIButton) {
        
        if let currentButton = selectedButton {
            if currentButton == sender {
                // 이미 선택된 버튼을 다시 클릭한 경우 선택 해제
                sender.isSelected = false
                // 기본 상태
                sender.backgroundColor = .clear // 기본 배경색
                sender.layer.shadowOpacity = 0
                removeCheckmark(from: sender)
                selectedButton = nil
                return
            } else {
                // 다른 버튼이 선택된 상태에서 새 버튼을 클릭한 경우
                // 기본 상태
                currentButton.backgroundColor = .clear // 기본 배경색
                currentButton.layer.shadowOpacity = 0
                currentButton.isSelected = false
                removeCheckmark(from: currentButton)
                    }
        }

        // 새로운 버튼 선택
        sender.isSelected = true
        selectedButton = sender
        sender.backgroundColor = UIColor.white.withAlphaComponent(1) // 선택된 배경색
        sender.layer.cornerRadius = 5
        sender.layer.shadowColor = UIColor.black.cgColor
        sender.layer.shadowOpacity = 0.15
        sender.layer.shadowOffset = CGSize(width: 0, height: 2)
        sender.layer.shadowRadius = 1
        // 체크 표시 추가
        addCheckmark(to: sender)
        
    }
    
    
    
    
    
    @objc func didTapAddButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    // 체크 표시 추가 함수
    private func addCheckmark(to button: UIButton) {
        let checkmarkImageView = UIImageView(image: UIImage(named: "checkMark"))
        checkmarkImageView.tag = 1001 // 체크마크를 식별할 수 있도록 tag 설정
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(checkmarkImageView)
            
        guard let imageView = button.imageView else { return }
            
        NSLayoutConstraint.activate([                checkmarkImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 11),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
        
    // 체크 표시 제거 함수
    private func removeCheckmark(from button: UIButton) {
        let checkmarkTag = 1001 // 체크마크에 할당된 tag 값
                
        for subview in button.subviews where subview is UIImageView {
            if subview.tag == checkmarkTag {
                subview.removeFromSuperview()
            }
                
        }
    }
    
    
    // 취소 버튼 눌렸을 때
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {    // 모달로 표시된 뷰 컨트롤러를 전부 닫음
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    
    func dismissTwice(from viewController: UIViewController?, completion: @escaping () -> Void) {
        guard let viewController = viewController else {
            completion()
            return
        }

        if let firstPresentingViewController = viewController.presentingViewController {
            viewController.dismiss(animated: true) {
                if let secondPresentingViewController = firstPresentingViewController.presentingViewController {
                    firstPresentingViewController.dismiss(animated: true) {
                        completion()
                    }
                } else {
                    completion()
                }
            }
        } else {
            completion()
        }
    }

    
    @objc private func saveButtonTapped(_ sender: UIButton) {        // 서버에 해당 유저의 기록을 올릴 것,
        guard let userId = getUserId() else { return }
        
        guard let cityData = cityData else { return }
        if let countryName = cityData["countryName"], let cityName =  cityData["cityName"], let selectedColor = selectedButton?.accessibilityIdentifier {
            guard let countryCode = countryCodes[countryName] else { return }
            //print(countryCode)
            //print(selectedColor)
            
            postMapData(userId: userId, cityName: cityName ,countryCode: countryCode, color: selectedColor) { result in
                    switch result {
                        case .success(let value):
                            print("업로드 성공: \(value)")
                            DispatchQueue.main.async {
                                // 이 코드를 사용하여 모든 모달 뷰 컨트롤러를 닫습니다.
                                self.dismissTwice(from: self) {
                                    // 모든 모달이 닫힌 후 알림을 보냅니다.
                                    NotificationCenter.default.post(name: .didPostMapData, object: nil)
                                }
                            }


                        case .failure(let error):
                            print("업로드 실패: \(error)")
                    }
                }

        }
                
 
        //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func getUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "id")
    }
    
    
    
    // 저장한 지도 여행 기록 post
    func postMapData(userId: Int, cityName: String, countryCode: String, color: String, completion: @escaping (Result<Any, Error>) -> Void) {
        let url = "http://3.34.111.233:8080/api/maps"
        
        guard let cityId = cityIds[cityName] else { return } // 만약 cityId를 찾을 수 없는 경우
                    
            // JSON 데이터 준비
            let parameters: [String: Any] = [
                "userId": userId,
                "cityId": cityId,
                "countryCode": countryCode,
                "color": color
            ]
                    
            // 3. Alamofire를 사용하여 POST 요청 보내기
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print("JSON 업로드 성공: \(value)")
                        completion(.success(value))
                    case .failure(let error):
                        print("JSON 업로드 실패: \(error)")
                        completion(.failure(error))
                    }
                }

        }
        

    
    
    
    
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}


extension Notification.Name {
    static let didPostMapData = Notification.Name("didPostMapData")
}
