//
//  LoginViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import Alamofire
import SwiftyJSON
import UIKit
import AuthenticationServices
import KakaoSDKUser
import SnapKit

class LoginViewController: UIViewController {
    
    var loginInfo: [String: Any]? = [:]
    
    class PaddedTextField: UITextField {
        var padding: UIEdgeInsets
        
        init(padding: UIEdgeInsets) {
            self.padding = padding
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // 텍스트 영역의 위치를 조정
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        // 편집 시 텍스트 영역의 위치를 조정
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        // 플레이스홀더 텍스트 영역의 위치를 조정
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }

    class CustomLabelTextFieldView: UIView {
        let label: UILabel
        let emailField: PaddedTextField
        let passwordField: PaddedTextField
        let validationLabel: UILabel

        var text1: String? {
            return emailField.text
        }
        
        var text2: String? {
            return passwordField.text
        }

        init(labelText: String, emailPlaceholder: String, passwordPlaceholder: String, validationText: String) {
            self.label = UILabel()
            self.emailField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            self.passwordField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            self.validationLabel = UILabel()

            super.init(frame: .zero)

            // Label setup
            label.text = labelText
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            label.textColor = .black
            label.textAlignment = .left

            // Simplified TextField setup
            setupTextField(emailField, placeholder: emailPlaceholder)
            setupTextField(passwordField, placeholder: passwordPlaceholder)
            self.passwordField.isSecureTextEntry = true

            // ValidationLabel setup
            validationLabel.text = validationText
            validationLabel.textColor = UIColor(hex: "#FD2D69")
            validationLabel.font = UIFont.systemFont(ofSize: 12)
            validationLabel.isHidden = true

            // Add subviews
            addSubview(label)
            addSubview(emailField)
            addSubview(passwordField)
            addSubview(validationLabel)

            // Set constraints
            label.snp.makeConstraints { make in
                make.top.equalToSuperview()
            }
            validationLabel.snp.makeConstraints { make in
                make.centerY.equalTo(label.snp.centerY)
                make.trailing.lessThanOrEqualToSuperview()
            }
            emailField.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview() // Match leading and trailing edges
                make.height.equalTo(50)
            }

            passwordField.snp.makeConstraints { make in
                make.top.equalTo(emailField.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview() // Match leading and trailing edges
                make.height.equalTo(50)
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupTextField(_ textField: PaddedTextField, placeholder: String) {
            textField.placeholder = placeholder
            textField.borderStyle = .none
            textField.font = UIFont.systemFont(ofSize: 16)
            textField.backgroundColor = UIColor.white
            textField.layer.borderColor = UIColor(hex: "#D8D8D8").cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5.0
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOpacity = 0.1
            textField.layer.shadowOffset = CGSize(width: 3, height: 3)
            textField.layer.shadowRadius = 5.0
        }
    }
    
    var status = false
    
    let loginField = CustomLabelTextFieldView(labelText: "로그인", emailPlaceholder: "| 이메일을 입력해 주세요", passwordPlaceholder: "| 비밀번호를 입력해 주세요", validationText: "아이디 혹은 비밀번호를 확인해 주세요")
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(hex: "#5833FF")
        label.textAlignment = .center
        return label
    }()
    
    // UI Elements
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = UIColor(hex: "#D3D3D3")
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
        let isFormValid = (isValidEmail(email)) && (isValidPassword(password))
        
        loginInfo?["email"] = loginField.text1
        loginInfo?["password"] = loginField.text2
        
       loginButton.isEnabled = isFormValid
        loginButton.backgroundColor = isFormValid ? UIColor(hex: "#6744FF") : UIColor(hex: "#D3D3D3")
    }
    
    func checkLoginInfo() {
        loginField.emailField.layer.borderColor = UIColor(hex: "#FE2494").cgColor
        loginField.passwordField.layer.borderColor = UIColor(hex: "#FE2494").cgColor
        loginField.validationLabel.isHidden = false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Basic email validation regex
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=?.,<>]).{8,15}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func sendLoginRequest() {
        guard let url = URL(string: "http://3.34.123.244:8080/user/login") else { return }
        
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
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor(hex: "A7A7A7")
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(backButton)
        
        // Set up constraints using SnapKit
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

