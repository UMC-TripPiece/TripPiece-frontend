//
//  SelfieLogViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 8/19/24.
//

import UIKit
import SnapKit

class SelfieLogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var travelId: Int
            
        init(travelId: Int) {
            self.travelId = travelId
            super.init(nibName: nil, bundle: nil)
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    var selectedImageData: Data?
    var mySelfie: UIImage?
    var status = false
    
    //MARK: - UI
    private lazy var customNavBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "셀카를 남겨보세요!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 현재 여행자님의 모습을 \n셀카로 담아보세요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "subtitle")
        return label
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selfieEmoji")
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
    
    private lazy var photoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(hex: "A7A7A7").cgColor // 테두리 색상 설정
        view.layer.borderWidth = 1.0
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(hex: "323232")
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var addPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 사진 추가"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "| 설명을 적어주세요"
        textField.borderStyle = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) // Add this line
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록 추가", for: .normal)
        button.backgroundColor = UIColor(hex: "D3D3D3")
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.addTarget(self, action: #selector(addRecord), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        setupDismissKeyboardGesture()
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()
        
        // NotificationCenter 관찰자 추가
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleImageView)
        view.addSubview(addButton)
        
        view.addSubview(grayBackgroundView)
        
        grayBackgroundView.addSubview(contentStackView)
        
        photoContainerView.addSubview(photoImageView)
        photoContainerView.addSubview(addPhotoLabel)
        photoContainerView.addSubview(descriptionTextField)
        contentStackView.addArrangedSubview(photoContainerView)
        contentStackView.addArrangedSubview(addButton)
        setConstraints()
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
        // `photoContainerView` 제약 조건 설정
        photoContainerView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview()
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(photoContainerView.snp.top).offset(8)
            make.leading.trailing.equalTo(photoContainerView).inset(8)
        }
        addPhotoLabel.snp.makeConstraints { make in
            make.center.equalTo(photoImageView)
        }
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(photoImageView)
            make.height.equalTo(44)
            make.bottom.equalTo(photoContainerView.snp.bottom).offset(-20)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(50) // 버튼의 높이를 50으로 설정
        }
    }
    
    //MARK: - Function
    
    ///뒤로가기 버튼
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
    
    @objc private func selectPhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        let cameraAction = UIAlertAction(title: "카메라 열기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                // 카메라 사용 불가 처리
                let alert = UIAlertController(title: "카메라 사용 불가", message: "카메라를 사용할 수 없습니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let libraryAction = UIAlertAction(title: "라이브러리에서 사진 선택", style: .default) { _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cameraAction)
            alert.addAction(libraryAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            mySelfie = selectedImage
            selectedImageData = selectedImage.jpegData(compressionQuality: 0.2)
            addPhotoLabel.isHidden = true
            validateInput()  // Call validation after selecting an image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func validateInput() {
        let isDescriptionValid = !(descriptionTextField.text?.isEmpty ?? true)
        let isImageSelected = selectedImageData != nil
        addButton.isEnabled = isDescriptionValid && isImageSelected
        addButton.backgroundColor = addButton.isEnabled ? UIColor(hex: "6644FF") : UIColor(hex: "D3D3D3")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        validateInput()  // Call validation when the text changes
    }
    
    @objc private func addRecord() {
        // 기록 추가 기능 구현
        guard let url = URL(string: "http://3.34.111.233:8080/mytravels/\(travelId)/selfie") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let refreshToken = getRefreshToken() {
            request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        }
        
        // 멀티파트 데이터 생성
        var body = Data()
        
        // 'memo' field
            let descriptionText = descriptionTextField.text ?? ""
            let memo = """
            {
              "description": "\(descriptionText)"
            }
            """
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"memo\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(memo)\r\n".data(using: .utf8)!)
        
        // 이미지 파일 추가
        
        if let imageData = selectedImageData {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"selfie.png\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making POST request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unexpected response: \(String(describing: response))")
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                print("Unexpected response: \(String(describing: response))")
                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                    print("Error message: \(errorMessage)")
                }
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
                DispatchQueue.main.async {
                                // 응답이 성공적일 경우 status를 true로 변경
                    self.status = true
                                self.proceedIfLogUpdateSuccessful()
                            }
            }
        }
        task.resume()
    }

   
    func proceedIfLogUpdateSuccessful() {
        if status {
            guard let thumbnail = mySelfie else {
                // 에러 처리: 텍스트나 썸네일이 없을 때
                let alert = UIAlertController(title: "경고", message: "썸네일 또는 텍스트가 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                present(alert, animated: true)
                return
            }
            let recordCompleteVC = SelfieRecordCompleteViewController()
            recordCompleteVC.setVideoComplete(with: thumbnail)
            recordCompleteVC.modalPresentationStyle = .fullScreen
            present(recordCompleteVC, animated: true, completion: nil)
        }
    }
}
