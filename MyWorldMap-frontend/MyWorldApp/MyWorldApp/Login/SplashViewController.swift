//
//  SplashViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 8/12/24.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
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
        navigateToMainScreen()
        
    }
    
    private func setupSplashScreen() {
        view.addSubview(backgroundImageView)
    }
    
    private func navigateToMainScreen() {
        // 2초 후에 메인 화면으로 이동
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let SignUpViewController = SignUpViewController()
            SignUpViewController.modalTransitionStyle = .crossDissolve
            SignUpViewController.modalPresentationStyle = .fullScreen
            self.present(SignUpViewController, animated: true, completion: nil)
        }
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
