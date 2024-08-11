//
//  LogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/5/24.
//

import UIKit
import SnapKit

class LogViewController: UIViewController {
    lazy var logButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dummyim"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startTravel), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(logButton)
        logButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()  // 화면 전체에 버튼이 꽉 차도록 설정
        }
    }
    
    @objc private func startTravel() {
        let viewController = StartLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
