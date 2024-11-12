//
//  LoginViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import Alamofire
import UIKit
import AuthenticationServices
import KakaoSDKUser
import SnapKit

class LoginViewController: UIViewController {
    
    var loginInfo: [String: Any]? = [:]
    
    var status = false
    
    let loginField = CustomLabelTextFieldView(labelText: "로그인", emailPlaceholder: "| 이메일을 입력해 주세요", passwordPlaceholder: "| 비밀번호를 입력해 주세요", validationText: "아이디 혹은 비밀번호를 확인해 주세요")
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Constants.Colors.mainPurple
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = Constants.Colors.bgGray
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(loginField)
        view.addSubview(loginButton)
    }
    
    func setupActions() {
        loginField.emailField.addTarget(self, action: #selector(checkFormValidity), for: .editingChanged)
        loginField.passwordField.addTarget(self, action: #selector(checkFormValidity), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupActions()
        setupNavigationBar()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        loginField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20) // Leading and trailing match with button
            make.height.equalTo(140)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(loginField) // Match with loginField
            make.height.equalTo(50)
        }
    }
    
    @objc func loginButtonTapped() {
        sendLoginRequest()
    }
    
    @objc func checkFormValidity() {
        let email = loginField.text1 ?? ""
        let password = loginField.text2 ?? ""
        let isFormValid = (ValidationUtility.isValidEmail(email)) && (ValidationUtility.isValidPassword(password))
        
        loginInfo?["email"] = loginField.text1
        loginInfo?["password"] = loginField.text2
        
       loginButton.isEnabled = isFormValid
        loginButton.backgroundColor = isFormValid ? Constants.Colors.mainPurple : Constants.Colors.bgGray
    }
    
    func checkLoginInfo() {
        loginField.emailField.layer.borderColor = Constants.Colors.mainPink?.cgColor
        loginField.passwordField.layer.borderColor = Constants.Colors.mainPink?.cgColor
        loginField.validationLabel.isHidden = false
    }
    
    func sendLoginRequest() {
        guard let url = URL(string: "http://3.34.111.233:8080/user/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("*/*", forHTTPHeaderField: "accept")

        // JSON 데이터를 문자열로 변환
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginInfo, options: [])
                request.httpBody = jsonData
            } catch {
                print("Failed to serialize JSON: \(error)")
                return
            }
            
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
                        DispatchQueue.main.async {
                                            self.checkLoginInfo()
                                        }
                    }
                    return
                }
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                    DispatchQueue.main.async {
                            // JSON 파싱을 통해 refreshToken을 추출
                            if let jsonData = responseString.data(using: .utf8) {
                                do {
                                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                                       let result = json["result"] as? [String: Any],
                                       let refreshToken = result["refreshToken"] as? String,
                                       let id = result["id"] as? Int {
                                        
                                        // refreshToken을 UserDefaults에 저장
                                        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                                        UserDefaults.standard.set(id, forKey: "id")
                                        
                                        // 응답이 성공적일 경우 status를 true로 변경
                                        self.status = true
                                        self.proceedIfSignupSuccessful()
                                    }
                                } catch {
                                    print("JSON 파싱 에러: \(error.localizedDescription)")
                                }
                            }
                        }
                }
            }
            task.resume()
    }
    
    func proceedIfSignupSuccessful() {
        if status {
            let tabBarController = TabBar()
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
        }
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(Constants.Colors.black3 ?? .systemGray , renderingMode: .alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
