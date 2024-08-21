//
//  FloatingBadgeView.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/19/24.
//

import UIKit

class FloatingBadgeView: UIView {
    

    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userProfileImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "여행자님"
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


