//
//  MyPageViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit
import SnapKit
import SDWebImage

class MyPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    var userInfo: [String: Any] = [:]
    
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
        label.text = "0\n여행기"
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor(hex: "FD2D69"), for: .normal)
        button.backgroundColor = UIColor(hex: "6644FF")?.withAlphaComponent(0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserProfile()
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
        let superViewWidth = view.frame.width

        let mapStackView = UIStackView(arrangedSubviews: [mapPublicLabel, mapPublicSwitch])
        mapStackView.axis = .horizontal
        mapStackView.spacing = superViewWidth * 0.40
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
        let editVC = MyPageEditViewController()
        editVC.modalPresentationStyle = .fullScreen // Present the edit view controller full screen
        editVC.userInfo = userInfo
        print(userInfo)
        present(editVC, animated: true, completion: nil)
    }
    
    @objc func logoutTapped() {
        // 로그아웃 URL
        guard let url = URL(string: "http://3.34.111.233:8080/user/logout") else {
            print("Invalid URL")
            return
        }
        
        // 요청 구성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 요청 헤더 설정
        request.setValue("*/*", forHTTPHeaderField: "accept")
        if let refreshToken = getRefreshToken(){
            request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
            print("refreshToken: \(refreshToken)")
        }
        
        
        // 비동기 네트워크 요청
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러 처리
            if let error = error {
                print("Error during logout: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unexpected response: \(String(describing: response))")
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
                DispatchQueue.main.async {
                    self.proceedIfLogOutSuccessful()
                    }
            }
        }
        
        task.resume()
    }
    
    func proceedIfLogOutSuccessful() {
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        let SignUpVC = SignUpViewController()
        SignUpVC.modalPresentationStyle = .fullScreen
        present(SignUpVC, animated: true, completion: nil)
    }
    
    func fetchUserProfile() {
        guard let url = URL(string: "http://3.34.111.233:8080/user/myprofile") else { return }
        var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("*/*", forHTTPHeaderField: "accept")
        if let refreshToken = getRefreshToken(){request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }

                    guard let data = data else {
                        print("No data received.")
                        return
                    }

                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                        do {
                                        // JSON 응답을 디코딩합니다.
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                        
                            if let isSuccess = json?["isSuccess"] as? Bool, isSuccess,
                            let result = json?["result"] as? [String: Any],
                            let nickname = result["nickname"] as? String,
                               let travelNum = result["travelNum"] as? Int,
                               let gender = result["gender"] as? String,
                               let country = result["country"] as? String,
                               let birth = result["birth"] as? String,
                               let isPublic = result["isPublic"] as? Bool,
                            let profileImgString = result["profileImg"] as? String,
                            let profileImgURL = URL(string: profileImgString) {
                            DispatchQueue.main.async {
                                self.nameLabel.text = "\(nickname)님"
                                self.travelLogsLabel.text = "\(travelNum)\n여행기"
                                self.profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "profileExample"))
                                self.mapPublicSwitch.isOn = isPublic
                                self.userInfo["profileImg"] = profileImgURL
                                self.userInfo["nickname"] = nickname
                                self.userInfo["gender"] = gender
                                self.userInfo["country"] = country
                                self.userInfo["birth"] = birth
                                        }
                                        }
                                    } catch {
                                        print("Error decoding JSON: \(error.localizedDescription)")
                                    }
                    }
                }
                task.resume()
    }
}
