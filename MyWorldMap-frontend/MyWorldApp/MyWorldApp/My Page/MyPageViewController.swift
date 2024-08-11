//
//  MyPageViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_image")) // Replace with actual image name
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
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
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
    }
    
    func setupViews() {
        // Background view for purple top
        let topBackgroundView = UIView()
        topBackgroundView.backgroundColor = .purple
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundView)
        
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // MY PAGE label
        let myPageLabel = UILabel()
        myPageLabel.text = "MY PAGE"
        myPageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        myPageLabel.textColor = .white
        myPageLabel.textAlignment = .center
        myPageLabel.translatesAutoresizingMaskIntoConstraints = false
        topBackgroundView.addSubview(myPageLabel)
        
        NSLayoutConstraint.activate([
            myPageLabel.topAnchor.constraint(equalTo: topBackgroundView.topAnchor, constant: 40),
            myPageLabel.centerXAnchor.constraint(equalTo: topBackgroundView.centerXAnchor)
        ])
        
        // Profile image
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Followers, following, and travel logs labels
        let stackView = UIStackView(arrangedSubviews: [followersLabel, followingLabel, travelLogsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // Map public switch and label
        let mapStackView = UIStackView(arrangedSubviews: [mapPublicLabel, mapPublicSwitch])
        mapStackView.axis = .horizontal
        mapStackView.spacing = 10
        mapStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapStackView)
        
        NSLayoutConstraint.activate([
            mapStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            mapStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        // Logout button
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: mapStackView.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    
    @objc func logoutTapped() {
        // Logout action
        print("Logout tapped")
    }
}

