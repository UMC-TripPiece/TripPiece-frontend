//
//  LogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/5/24.
//

import UIKit
import SnapKit

class LogViewController: UIViewController {
    private lazy var navBar: GradientNavigationBar = {
        let nav = GradientNavigationBar(title: "여행자님의 기록")
        return nav
    }()
    private lazy var logButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startTravel), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(navBar)
        setupUI()
    }
    //MARK: Set Up UI
    private func setupUI() {
        view.addSubview(logButton)
        setConstraints()
    }
    func setConstraints() {
        navBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(107)
        }
        logButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func startTravel() {
        let viewController = StartLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
