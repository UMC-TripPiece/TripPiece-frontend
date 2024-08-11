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
//        button.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        return button
        }()
    
    let LoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미 계정이 있으신가요?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        return button
        }()
    
    //MARK: - UI Properties
    let loginview = loginView()

    lazy var kakaoAuthVM: KakaoAuthVM = KakaoAuthVM()

    //MARK: - Define Method
    // VC의 기본 view 지정
    override func loadView() {
        view = loginview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }

    // 뷰 관련 세팅
    func setView() {
        // loginview의 서브뷰로 kakaoButton을 추가합니다.
        loginview.addSubview(emailLoginButton)
        loginview.addSubview(kakaoLoginButton)
        loginview.addSubview(LoginButton)

        // 네비게이션 바 숨김
        navigationController?.navigationBar.isHidden = true
    }

    func setConstraints() {
        let leading: CGFloat = 30
        let superViewHeight = UIScreen.main.bounds.height
        
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.78)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(kakaoLoginButton.snp.width).multipliedBy(0.15)
                }
        
        // kakaoButton 오토레이아웃
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.85)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(kakaoLoginButton.snp.width).multipliedBy(0.15)
        }
        
        LoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(superViewHeight * 0.92)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
    }

    // emailLoginButton 클릭 이벤트
        @objc func emailLoginButtonTapped(_ sender: UIButton) {
            let signUpVC = SignUpViewController()
//            self.navigationController?.pushViewController(signUpVC, animated: true)
            signUpVC.modalPresentationStyle = .fullScreen
            present(signUpVC, animated: true, completion: nil)
        }
    
    @objc func LoginButtonTapped(_ sender: UIButton) {
        let signUpVC = SignUpViewController()
//            self.navigationController?.pushViewController(signUpVC, animated: true)
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
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
//    @objc func kakaoButtonTapped(_ sender: UIButton) {
//        Task { [weak self] in
//            if await kakaoAuthVM.KakaoLogin() {
//                DispatchQueue.main.async { [weak self] in
//                    UserApi.shared.me() { [weak self] (user, error) in
//                        if let error = error {
//                            print(error)
//                        }
//                        
//                        // 유저 정보 저장을 위해 Kakao로부터 받아올 수 있는 정보를 변수에 저장
//                        let userID = user?.kakaoAccount?.ci
//                        let userName = user?.kakaoAccount?.profile?.nickname
//                        let userEmail = user?.kakaoAccount?.email
//
//                        let VC = UserInfoViewController()
//                        VC.userInfo.id = userID ?? ""
//                        VC.userInfo.name = userName ?? ""
//                        VC.userInfo.email = userEmail ?? ""
//                        
//                        VC.loginPath = "/kakao"
//                        self?.navigationController?.pushViewController(VC, animated: true)
//                    }
//                }
//            } else {
//                print("Login failed.")
//            }
//        }
//        
//        
//    }
}

