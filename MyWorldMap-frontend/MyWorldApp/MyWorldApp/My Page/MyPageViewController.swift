//
//  MyPageViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedImageData: Data?
    
    var backgroundImageView: UIImageView!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Page"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(hex: "#FFFFFF")
        label.textAlignment = .center
        return label
    }()

    let profileImageView = UIImageView()
    
    let profileEditIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImageEdit"))
        imageView.isUserInteractionEnabled = true // Enable user interaction
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "여행자 님"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "0\n팔로워"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "0\n팔로잉"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let travelLogsLabel: UILabel = {
        let label = UILabel()
        label.text = "1\n여행기"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let mapPublicSwitch: UISwitch = {
        let mapSwitch = UISwitch()
        return mapSwitch
    }()
    
    let mapPublicLabel: UILabel = {
        let label = UILabel()
        label.text = "내 지도 공개 여부"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "FD2D69")
        button.layer.cornerRadius = 10
        button.addTarget(MyPageViewController.self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        
        configureTapGestureForProfileEditIcon()
    }
    
    func setupViews() {
        backgroundImageView = UIImageView(image: UIImage(named: "myPageTop"))
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.3) // You can adjust this height as needed
        }
        backgroundImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        profileImageView.image = UIImage(named: "profileExample")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 70
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundImageView.snp.bottom).offset(-95) // Overlaps the background image
            make.width.height.equalTo(140) // Profile image size
        }
        
        view.addSubview(profileEditIconView)

        profileEditIconView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalTo(profileImageView.snp.trailing).inset(17)
            make.centerY.equalTo(profileImageView.snp.top).inset(17)
        }
        // Name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        // Followers, following, and travel logs labels
        let stackView = UIStackView(arrangedSubviews: [followersLabel, followingLabel, travelLogsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        // Map public switch and label
        let mapStackView = UIStackView(arrangedSubviews: [mapPublicLabel, mapPublicSwitch])
        mapStackView.axis = .horizontal
        mapStackView.spacing = 10
        view.addSubview(mapStackView)
        
        mapStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        
        // Logout button
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(mapStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    func configureTapGestureForProfileEditIcon() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileEdit))
        profileEditIconView.addGestureRecognizer(tapGesture)
    }
    
    @objc func profileEdit() {
        let editViewController = MyPageEditViewController()
        editViewController.modalPresentationStyle = .fullScreen // Present the edit view controller full screen
        present(editViewController, animated: true, completion: nil)
    }
    
    @objc func logoutTapped() {
        // Logout action
        print("Logout tapped")
    }
}
