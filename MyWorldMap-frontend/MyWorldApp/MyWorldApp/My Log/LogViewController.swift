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
        button.setTitle("여행 시작", for: .normal)
        button.backgroundColor = .main
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startTravel), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(logButton)
        logButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func startTravel() {
        let viewController = StartLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

}
