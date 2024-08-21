//
//  UserInfoViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 7/29/24.
//

import UIKit
import SnapKit
import SDWebImage

class MyPageEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    var userInfo: [String: Any]?
    
    var selectedImageData: Data?
    var status = false
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
    var profileImageView = UIImageView()
    let nicknameTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let genderLabel = UILabel()
    let genderSegmentedControl = UISegmentedControl(items: ["남성", "여성"])
    let birthdateLabel = UILabel()
    let birthdateTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let birthdatePicker = UIDatePicker()
    let countryLabel = UILabel()
    let countryTextField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    let updateButton = UIButton(type: .system)
    
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
//        if let userInfo = userInfo as? [String: Any],
//           let profileImgURL = userInfo["profileImg"] as? URL {
//            profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "profileExample")) { image, error, cacheType, url in
//                if let error = error {
//                    print("Image loading failed with error: \(error.localizedDescription)")
//                }
//            }
//        } else if let urlString = userInfo?["profileImg"] as? String,
//                  let profileImgURL = URL(string: urlString) {
//            profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "profileExample")) { image, error, cacheType, url in
//                if let error = error {
//                    print("Image loading failed with error: \(error.localizedDescription)")
//                }
//            }
//
//        } else {
//            profileImageView.image = UIImage(named: "profileExample")
//        }
        
        if let profileImgUrl = userInfo?["profileImg"] as? String {
            downloadImageData(from: profileImgUrl) { [weak self] imageData in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let imageDataLoad = imageData, let image = UIImage(data: imageDataLoad) {
                        print("Image data downloaded and converted successfully.")
                        self.profileImageView.image = image
                    } else {
                        print("Failed to load image data, using placeholder image.")
                        self.profileImageView.image = UIImage(named: "profileExample")
                    }
                }
            }
        } else {
            // userInfo에 profileImg 키가 없는 경우 기본 이미지를 설정합니다.
            print("No profile image URL found in userInfo, using placeholder image.")
            profileImageView.image = UIImage(named: "profileExample")
        }
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        // 나머지 UI 요소 설정
        var nickname = userInfo?["nickname"] as? String
        nicknameTextField.setPlaceholder("사용할 닉네임을 입력해주세요")
        nicknameTextField.text = nickname
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        genderLabel.text = "성별"
        
        var gender = userInfo?["gender"] as? String
        if gender == "MALE" {
            genderSegmentedControl.selectedSegmentIndex = 0
        } else {
            genderSegmentedControl.selectedSegmentIndex = 1
        }
        genderSegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        birthdateLabel.text = "생년월일"
        
        var birth = userInfo?["birth"] as? String
        birthdateTextField.setPlaceholder( "YYYY/MM/DD")
        birthdateTextField.text = birth
        birthdateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        countryLabel.text = "국적"
        
        countryTextField.setPlaceholder("🇰🇷 대한민국", color: .black)
        countryTextField.isUserInteractionEnabled = false
        
        updateButton.setTitle("완료", for: .normal)
        updateButton.setTitleColor(UIColor(hex: "7E7E7E"), for: .normal)
        updateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
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
        view.addSubview(updateButton)
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
        updateButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.centerY.equalTo(profileLabel.snp.centerY)
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

    func downloadImageData(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            // 성공적으로 데이터를 다운로드한 경우
            completion(data)
        }
        
        task.resume()
    }
    
    @objc func updateButtonTapped() {
        sendUpdateRequest()
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            
            // 선택된 이미지를 jpegData로 변환하여 저장
            selectedImageData = selectedImage.jpegData(compressionQuality: 0.2)
            print("이미지 저장 완료")
        } else {
            print("이미지 선택 실패")
        }
        
        // 이미지 피커 닫기
        dismiss(animated: true, completion: nil)
    }
    
    // 닉네임 또는 생년월일 변경 시 호출
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkFormValidity()
    }
    
    // 성별 선택 시 호출
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let selectedValue = sender.titleForSegment(at: selectedIndex)
        if selectedValue == "남성" {
            userInfo?["gender"] = "MALE"
        } else if selectedValue == "여성" {
            userInfo?["gender"] = "FEMALE"
            print(userInfo)
        }
        checkFormValidity()
    }
    
    // 생년월일 변경 시 호출
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        birthdateTextField.text = dateFormatter.string(from: sender.date)
        userInfo?["birth"] = birthdateTextField.text
        checkFormValidity()
    }
    
    // 폼 유효성 검사
    func checkFormValidity() {
        let isFormValid = !(nicknameTextField.text?.isEmpty ?? true) &&
            !(birthdateTextField.text?.isEmpty ?? true) &&
            (genderSegmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment)
        
        userInfo?["nickname"] = nicknameTextField.text
        userInfo?["country"] = "South Korea"
    }
    
//    func sendUpdateRequest() {
//        guard let url = URL(string: "http://3.34.123.244:8080/user/update") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        if let refreshToken = getRefreshToken(){request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")}
//
//        // 멀티파트 데이터 생성
//        var body = Data()
//
//        // 이미지 파일 추가
//        var modifiedUserInfo = userInfo
//        if let imageData = selectedImageData {
//            modifiedUserInfo?.removeValue(forKey: "profileImg")
//            body.append("--\(boundary)\r\n".data(using: .utf8)!)
//            body.append("Content-Disposition: form-data; name=\"profileImg\"\r\n".data(using: .utf8)!)
//            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//            body.append(imageData)
//            body.append("\r\n".data(using: .utf8)!)
//            print("이미지 변경")
//            print(body)
//            print(modifiedUserInfo)
//        } else {
//            if let existingImageUrl = modifiedUserInfo?["profileImg"] as? String {
//                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"profileImg\"\r\n".data(using: .utf8)!)
//                    body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
//                    body.append(existingImageUrl.data(using: .utf8)!)
//                    body.append("\r\n".data(using: .utf8)!)
//                modifiedUserInfo?.removeValue(forKey: "profileImg")
//                print("이미지 변경 x")
//                print(body)
//                print(modifiedUserInfo)
//                }
//
//        }
//
//        // JSON 데이터를 문자열로 변환
//        let jsonData = try! JSONSerialization.data(withJSONObject: modifiedUserInfo, options: [])
//        let jsonString = String(data: jsonData, encoding: .utf8)!
//
//        // 'info' 필드 추가
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"info\"\r\n\r\n".data(using: .utf8)!)
//        body.append("\(jsonString)\r\n".data(using: .utf8)!)
//
//        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//
//        request.httpBody = body
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error making POST request: \(error)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Unexpected response: \(String(describing: response))")
//                return
//            }
//
//            if !(200...299).contains(httpResponse.statusCode) {
//                print("Unexpected response: \(String(describing: response))")
//                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
//                    print("Error message: \(errorMessage)")
//                }
//                return
//            }
//
//            if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response data: \(responseString)")
//                DispatchQueue.main.async {
//                                // 응답이 성공적일 경우 status를 true로 변경
//                    self.status = true
//                                self.proceedIfSignupSuccessful()
//                            }
//            }
//        }
//        task.resume()
//    }

    func sendUpdateRequest() {
        guard let url = URL(string: "http://3.34.123.244:8080/user/update") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let refreshToken = getRefreshToken() {
            request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        }
        
        var body = Data()
        
        // userInfo에서 NSURL을 문자열로 변환
        if var modifiedUserInfo = userInfo {
            if let urlValue = modifiedUserInfo["profileImg"] as? URL {
                modifiedUserInfo["profileImg"] = urlValue.absoluteString
            }
            
            if let imageData = selectedImageData {
                modifiedUserInfo.removeValue(forKey: "profileImg")
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"profileImg\"; filename=\"profile.png\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            } else if let existingImageUrl = modifiedUserInfo["profileImg"] as? String {
                modifiedUserInfo.removeValue(forKey: "profileImg")
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"profileImg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
                body.append(existingImageUrl.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: modifiedUserInfo, options: [])
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"info\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(jsonString)\r\n".data(using: .utf8)!)
            } catch {
                print("Error serializing JSON: \(error)")
                return
            }
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
                    self.status = true
                    self.proceedIfSignupSuccessful()
                }
            }
        }
        task.resume()
    }
    
    func proceedIfSignupSuccessful() {
        if status {
            let myPageVC = MyPageViewController()
            myPageVC.modalPresentationStyle = .fullScreen
            present(myPageVC, animated: true, completion: nil)
        }
    }
}
