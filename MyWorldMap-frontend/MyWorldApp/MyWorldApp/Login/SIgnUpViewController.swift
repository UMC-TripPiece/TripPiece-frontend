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

class SignUpViewController: UIViewController {
    
    var userInfo: [String: Any] = [:]
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgroundImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let emailLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("E-mail로 시작하기", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(emailLoginButtonTapped), for: .touchUpInside)
        return button
    }()

    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "btn_login_kakao")?.withRenderingMode(.alwaysOriginal) {
            button.setImage(image, for: .normal)
        } else {
            print("Image btn_login_kakao not found!")
        }
        button.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미 계정이 있으신가요?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var kakaoAuthVM: KakaoAuthVM = KakaoAuthVM()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }

    // 뷰 관련 세팅
    func setView() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(emailLoginButton)
        self.view.addSubview(kakaoLoginButton)
        self.view.addSubview(loginButton)

        navigationController?.navigationBar.isHidden = true
    }

    func setConstraints() {
        let leading: CGFloat = 30
        let superViewHeight = UIScreen.main.bounds.height
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
            make.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            make.leading.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.1)
            make.trailing.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
        }
        
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.78)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(emailLoginButton.snp.width).multipliedBy(0.15)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.85)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(kakaoLoginButton.snp.width).multipliedBy(0.15)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.92)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
    }

    @objc func emailLoginButtonTapped(_ sender: UIButton) {
        let signUpView = SignUpView(frame: self.view.bounds)
        signUpView.backgroundColor = .white
        self.view.addSubview(signUpView)
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
  
//    private func signupWithKakao() {
//        if UserApi.isKakaoTalkLoginAvailable() {
//            loginWithKakaoApp()
//        } else {
//            loginWithWeb()
//        }
//    }
//
//    private func loginWithKakaoApp() {
//        UserApi.shared.loginWithKakaoTalk { _, error in
//            if let error = error {
//                print(error)
//            } else {
//                print("loginWithKakaoApp() success.")
//
//                self.getUserID()
//            }
//        }
//    }
//
//    private func loginWithWeb() {
//
//        UserApi.shared.loginWithKakaoAccount { _, error in
//            if let error = error {
//                print(error)
//            } else {
//                print("loginWithKakaoAccount() success.")
//
//                self.getUserID()
//            }
//        }
//    }
//
//    private func getUserID() {
//        UserApi.shared.me {(user, error) in
//            if let error = error {
//                print(error)
//            } else {
//                if let userID = user?.id {
//                    UserDefaults.standard.set(String(userID), forKey: Const.UserDefaultsKey.userID)
//
//                    self.loginWithAPI(userID: String("Kakao@\(userID)"))
//                }
//            }
//        }
//    }
    
    // kakaoButton 클릭 이벤트
    @objc func kakaoButtonTapped(_ sender: UIButton) {
        Task { [weak self] in
            if await kakaoAuthVM.KakaoLogin() {
                DispatchQueue.main.async { [weak self] in
                    UserApi.shared.me() { [weak self] (user, error) in
                        if let error = error {
                            print(error)
                        }

                        // 유저 정보 저장을 위해 Kakao로부터 받아올 수 있는 정보를 변수에 저장
                        let userID = user?.kakaoAccount?.ci
                        let userName = user?.kakaoAccount?.profile?.nickname
                        let userEmail = user?.kakaoAccount?.email

                        let VC = ProfileViewController()
                        VC.userInfo?["providerId"] = userID ?? ""
                        VC.userInfo?["name"] = userName ?? ""
                        VC.userInfo?["email"] = userEmail ?? ""

                        VC.loginPath = "/kakao"
                        self?.navigationController?.pushViewController(VC, animated: true)
                    }
                }
            } else {
                print("Login failed.")
            }
        }


    }
}

