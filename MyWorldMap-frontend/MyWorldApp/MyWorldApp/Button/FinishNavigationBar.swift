//
//  Finish.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/23/24.
//

import UIKit
import SnapKit

class FinishNavigationBar: UINavigationBar {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var iconImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .black // 필요한 경우 색상 변경
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(logoImageView)
        addSubview(iconImageView)
        addSubview(closeButton) // closeButton을 추가

        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 105.72, height: 25.5))
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22)
            make.centerY.equalToSuperview()
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 48
        return newSize
    }

    @objc func back() {
        NotificationCenter.default.post(name: .backButtonTapped, object: nil)
    }

    @objc func close() {
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
