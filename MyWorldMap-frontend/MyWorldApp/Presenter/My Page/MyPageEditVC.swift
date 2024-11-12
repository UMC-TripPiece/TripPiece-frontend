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
    
    var userInfo: [String: Any]?
    
    var selectedImageData: Data?
    var status = false
    
    // UI 요소 선언
    let profileLabel = UILabel()
    var profileImageView = UIImageView()
    var profileEditIconView = UIImageView()
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
        view.backgroundColor = Constants.Colors.bg4
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
        profileLabel.textColor = Constants.Colors.mainPurple
        
        // 프로필 이미지 설정
        if let userInfo = userInfo as? [String: Any],
           let profileImgURL = userInfo["profileImg"] as? URL {
            profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "profileExample")) { image, error, cacheType, url in
                if let error = error {
                    print("Image loading failed with error: \(error.localizedDescription)")
                }
            }
        } else if let urlString = userInfo?["profileImg"] as? String,
                  let profileImgURL = URL(string: urlString) {
            profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "profileExample")) { image, error, cacheType, url in
                if let error = error {
                    print("Image loading failed with error: \(error.localizedDescription)")
                }
            }

        } else {
            profileImageView.image = UIImage(named: "profileExample")
        }
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        profileEditIconView = UIImageView(image: UIImage(named: "photoEditIcon"))
        profileEditIconView.isUserInteractionEnabled = true
        
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
        updateButton.setTitleColor(Constants.Colors.black3, for: .normal)
        updateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        // 뷰에 추가
        view.addSubview(profileLabel)
        view.addSubview(profileImageView)
        view.addSubview(profileEditIconView)
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
        profileEditIconView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalTo(profileImageView.snp.trailing).offset(-17)
            make.centerY.equalTo(profileImageView.snp.bottom).offset(-17)
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
        profileEditIconView.addGestureRecognizer(tapGesture)
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
//        guard let url = URL(string: "http://3.34.111.233:8080/user/update") else { return }
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
        guard let url = URL(string: "http://3.34.111.233:8080/user/update") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let refreshToken = getRefreshToken.getRefreshToken() {
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
            let tabBarController = TabBar()
            tabBarController.selectedIndex = 3
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
        }
    }
}
