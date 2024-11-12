//
//  SplashViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 8/12/24.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "splashView"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSplashScreen()
        setConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.getRefreshToken() != nil {
                        // refreshToken 이 있으면 메인 화면으로 이동
                self.navigateToMainScreen()
                    } else {
                        // refreshToken 이 없으면 로그인 화면으로 이동
                        self.navigateToSignUpScreen()
                    }
        }
        
    }
    
    private func setupSplashScreen() {
        view.addSubview(backgroundImageView)
    }

    func navigateToMainScreen() {
        let tabBarController = TabBar()
        // UIWindow의 rootViewController를 TabBarController로 설정
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = scene.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    // 로그인 화면 (SignUpViewController)으로 이동하는 함수
    func navigateToSignUpScreen() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    func setConstraints() {
        // SnapKit을 사용하여 제약 조건 설정
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
            make.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            make.leading.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.1)
            make.trailing.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
        }
    }
}
