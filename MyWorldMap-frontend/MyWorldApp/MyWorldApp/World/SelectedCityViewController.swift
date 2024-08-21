//
//  SelectedCityViewController.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/14/24.
//

import UIKit

class SelectedCityViewController: UIViewController {
    
    var cityData: [String: String]? // 받아올 도시 정보

    
    
    // MARK: - UI View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    
    // 오른쪽 위 'X'자 버튼
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dismissButton"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button.heightAnchor.constraint(equalToConstant: 14).isActive = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    private let countryImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor(named: "Black5")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40 // 이미지뷰의 크기에 맞춰 반지름을 설정해야 함
        imageView.layer.masksToBounds = true
        
        
        return imageView
    }()
    
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🇻🇳"  // 원하는 이모티콘 텍스트 설정
        label.font = UIFont.systemFont(ofSize: 60) // 레이블의 폰트 크기 조정
        label.textAlignment = .center
        return label
    }()
    
    
    private let numberOfPeoleLabel: UILabel = {
        let label = UILabel()
        let numberOfPeople = 108
        label.text = "\(numberOfPeople)명이 여행했어요!"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(named: "Main3")
        label.textAlignment = .center
        return label
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "하노이, 베트남"
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    
    private let cityExplainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        return view
    }()

    
    private let cityExplainLabel: UILabel = {
        let label = UILabel()
        label.text = "베트남의 수도로, 정치, 경제, 문화의 중심지입니다. \n 역사적으로 중요한 유적지와 건축물이 조화를 이루고 있습니다."
        label.textColor = UIColor(named: "Black2")
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    private let logStartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("여행 기록 시작", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "#280595")?.withAlphaComponent(0.1)
        button.setTitleColor(UIColor(named: "Main"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    

    private let mapColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("세계지도 색칠", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "Main")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        
        return stackView
    }()




    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4) // 반투명한 검정색 설정
        
        uiAddSubViews()
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        mapColorButton.addTarget(self, action: #selector(mapColorButtonTapped(_:)), for: .touchUpInside)
        logStartButton.addTarget(self, action: #selector(logStartButtonTapped(_:)), for: .touchUpInside)
        
        let randomInt = Int.random(in: 1...300)
        numberOfPeoleLabel.text = "\(randomInt)명이 여행했어요!"
        
        if let cityData = cityData {
            titleLabel.text = "\(cityData["cityName"] ?? ""), \(cityData["countryName"] ?? "")"
            cityExplainLabel.text = cityData["cityDescription"]
            emojiLabel.text = cityData["countryImage"]
            
        }
        
        setupConstraints()
        
    }
    
    
    private func uiAddSubViews() {
        view.addSubview(containerView)
        
        containerView.addSubview(countryImage)        // 레이블을 이미지 뷰에 추가
        countryImage.addSubview(emojiLabel)
        containerView.addSubview(numberOfPeoleLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cityExplainBackgroundView)
        containerView.addSubview(cityExplainLabel)
        containerView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(logStartButton)
        buttonsStackView.addArrangedSubview(mapColorButton)
        containerView.addSubview(dismissButton)
    }
    
    
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        numberOfPeoleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityExplainBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cityExplainLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        countryImage.heightAnchor.constraint(equalToConstant: 87).priority = .defaultLow // 뭐야?
        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 348),
            containerView.heightAnchor.constraint(equalToConstant: 333),
            
            //나라 image
            countryImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 34),
            countryImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryImage.widthAnchor.constraint(equalToConstant: 87),
            countryImage.heightAnchor.constraint(equalToConstant: 87),
            
            emojiLabel.centerXAnchor.constraint(equalTo: countryImage.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: countryImage.centerYAnchor),
            

            
            // 도시를 여행한 사람들의 수
            numberOfPeoleLabel.topAnchor.constraint(equalTo: countryImage.bottomAnchor, constant: 10),
            numberOfPeoleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: numberOfPeoleLabel.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            

            
            // UILabel 제약 조건
            cityExplainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityExplainLabel.centerYAnchor.constraint(equalTo: cityExplainBackgroundView.centerYAnchor),
            cityExplainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cityExplainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                        
            // UILabel 크기를 기준으로 backgroundView 크기 설정 (패딩 추가)
            cityExplainBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),            cityExplainBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cityExplainBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cityExplainBackgroundView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -12),
            
            // button stack view constraints
            buttonsStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 325),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            //dismissButton constraints
            dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    
    
    // MARK: - Functions
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {        // 모달로 표시된 뷰 컨트롤러를 닫음
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // 여행 기록 시작
    @objc func logStartButtonTapped(_ sender: UIButton) {
        print("여행 기록 시작 뷰")
    }
    
    
    
    // 세계지도 색칠하기
    @objc func mapColorButtonTapped(_ sender: UIButton) {
        let colorCityViewController = ColorCityViewController()
        colorCityViewController.modalPresentationStyle = .overCurrentContext
        colorCityViewController.modalTransitionStyle = .crossDissolve
        colorCityViewController.cityData = cityData
        present(colorCityViewController, animated: true, completion: nil)
    }
    
    
    
    
    
}
