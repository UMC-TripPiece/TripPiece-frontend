//
//  FloatingBadgeView.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/19/24.
//

import UIKit
import SDWebImage

class FloatingBadgeView: UIView {
    

    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 이미지를 원형으로 자르기 위한 설정
        imageView.layer.cornerRadius = 10 // 이미지 뷰의 너비/높이의 절반으로 설정
        imageView.clipsToBounds = true // 이미지를 레이어의 경계에 맞춰 자르기
        
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "여행자님"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let userProfileStackView : UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal // 수평 방향 스택 뷰
        stackView.alignment = .center // 중앙 정렬
        stackView.spacing = 5 // 간격 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        
        return stackView
    }()
    
            
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let globeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "worldPuzzleImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOpacity = 0.4
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "Main")?.cgColor
        
        addSubview(userProfileStackView)
        userProfileStackView.addArrangedSubview(profileImageView)
        userProfileStackView.addArrangedSubview(userNameLabel)
        addSubview(subtitleLabel)
        addSubview(globeImageView)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            
            userProfileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            userProfileStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            

            
            subtitleLabel.leadingAnchor.constraint(equalTo: userProfileStackView.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            subtitleLabel.trailingAnchor.constraint(equalTo: globeImageView.leadingAnchor, constant: -15),
            
            profileImageView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 20),
            profileImageView.heightAnchor.constraint(equalToConstant: 20),
            
            //globeImageView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: 35),
            globeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            globeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            globeImageView.widthAnchor.constraint(equalToConstant: 85),
            globeImageView.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    func updateProfile(userName: String) {
        userNameLabel.text = "\(userName) 님"
    }
    
    // 프로필 이미지를 업데이트하는 메서드 추가
    func updateProfileImage(with urlString: String) {
        if let profileImgURL = URL(string: urlString) {
            profileImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "userProfileImage")) { [weak self] image, error, cacheType, url in
                if let error = error {
                    print("Image loading failed with error: \(error.localizedDescription)")
                } else {
                    // 이미지 로드가 성공하면 필요한 작업을 추가로 수행할 수 있습니다.
                    print("Image successfully loaded")
                }
            }
        } else {
            print("Invalid URL string.")
        }
    }
    
    
    
    // 새로운 메서드 추가
    func updateSubtitleLabel(countryNum: Int, cityNum: Int) {
            
        let fullText = "현재까지 \(countryNum)개의 나라의\n\(cityNum)개의 도시를 방문했어요"
        let attributedString = NSMutableAttributedString(string: fullText)
            
        let countryRange = (fullText as NSString).range(of: "\(countryNum)개의 나라")
        let cityRange = (fullText as NSString).range(of: "\(cityNum)개의 도시")
            
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Main") ?? UIColor.blue, range: countryRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Main") ?? UIColor.blue, range: cityRange)
            
        subtitleLabel.attributedText = attributedString
    }
    
}


