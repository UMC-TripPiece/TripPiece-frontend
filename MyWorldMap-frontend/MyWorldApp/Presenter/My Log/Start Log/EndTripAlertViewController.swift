
//  EndTripAlertViewController.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/22/24.
//

import UIKit

class EndTripAlertViewController: UIViewController {
    
    var travelId: Int?

    init(travelId: Int) {
        self.travelId = travelId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    
    // 첫 번째 레이블: "잠깐!" (빨간색, Bold)
    private let firstLabel: UIView = {
        let firstLabel = UILabel()
        firstLabel.text = "잠깐!"
        firstLabel.textColor = UIColor(named: "Main3")
        firstLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        firstLabel.textAlignment = .center
        return firstLabel
    }()
    
        
            
    // 두 번째 레이블: "여행을 종료하시겠습니까?" (검정색, Bold)
    private let secondLabel: UIView = {
        let secondLabel = UILabel()
        secondLabel.text = "여행을 종료하시겠습니까?"
        secondLabel.textColor = UIColor(named: "Black1")
        secondLabel.font = UIFont.systemFont(ofSize: 22, weight: .black)
        secondLabel.textAlignment = .center
        return secondLabel
    }()
    
        
            
    // 세 번째 레이블: 설명 텍스트 (회색, Regular)
    private let thirdLabel: UIView = {
        let thirdLabel = UILabel()
        thirdLabel.text = "여행을 종료하면 다시 시작할 수 없으며\n여행 조각들은 여행기에 모아져서 저장됩니다."
        thirdLabel.textColor = UIColor(named: "Black2")
        thirdLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        thirdLabel.textAlignment = .center
        thirdLabel.numberOfLines = 0
        return thirdLabel
    }()
    
    private let labelStack: UIStackView = {
        // 스택 뷰 생성
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        button.setTitleColor(UIColor(named: "Black3"), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    
    private let endTripButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("여행 종료", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // 활성화 상태일 때
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
        view.addSubview(containerView)
        
        uiAddSubViews()
        setupConstraints()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        endTripButton.addTarget(self, action: #selector(endTripButtonTapped(_:)), for: .touchUpInside)
    }
    
    
    
    
    
    private func uiAddSubViews() {
        containerView.addSubview(buttonsStackView)
        containerView.addSubview(labelStack)
        labelStack.addArrangedSubview(firstLabel)
        labelStack.addArrangedSubview(secondLabel)
        labelStack.addArrangedSubview(thirdLabel)
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(endTripButton)
    }
    
    
    
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        

        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 348),
            containerView.heightAnchor.constraint(equalToConstant: 208),
            
            labelStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            labelStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            labelStack.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 20),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20),
            
            
            
            // Cancel and done button constraints
            buttonsStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 325),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)

        ])
    }
    
    
    
    // MARK: - Functions

    // 취소 버튼 눌렸을 때
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 여행 종료 버튼 눌렸을 때
    @objc func endTripButtonTapped(_ sender: UIButton) {
        guard let travelId = self.travelId else {
                print("Travel ID가 없습니다.")
                return
            }
        let puzzleViewController = PuzzleViewController()
        puzzleViewController.modalPresentationStyle = .overCurrentContext
        puzzleViewController.modalTransitionStyle = .crossDissolve
        guard let url = URL(string: "http://3.34.111.233:8080/mytravels/\(travelId)/end") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = ["travelId": travelId]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to encode parameters: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making POST request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unexpected response: \(String(describing: response))")
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                print("Unexpected response: \(String(describing: response))")
                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                    print("Error message: \(errorMessage)")
                }
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
                DispatchQueue.main.async {
                    let endVC = FinishPuzzleViewController(travelId: travelId)
                    endVC.modalPresentationStyle = .fullScreen
                    self.present(endVC, animated: true, completion: nil)
                            }
            }
        }
        task.resume()
    }
}

