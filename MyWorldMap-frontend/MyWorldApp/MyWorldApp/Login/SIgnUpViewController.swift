//
//  SIgnUpViewController.swift
//  MyWorldApp
//
//  Created by 이예성 on 7/29/24.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signUpView)
        print("View did load.")
//        setView()
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        
    }
    
//    func setView() {
//        signUpView.addSubview(signUpButton)
//                    // 네비게이션 바 숨김
//        navigationController?.navigationBar.isHidden = true
//        }

}
