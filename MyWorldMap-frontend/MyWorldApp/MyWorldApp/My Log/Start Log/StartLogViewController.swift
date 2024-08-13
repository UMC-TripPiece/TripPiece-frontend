//
//  StartLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/5/24.
//

import UIKit
import Alamofire

class StartLogViewController: UIViewController {
    //MARK: - UI
    private lazy var startNavBar: LogStartNavigationBar = {
        let nav = LogStartNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()

    private lazy var addCountryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus country"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "도시 추가"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var grayBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BgColor1")
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var travelPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 기간"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var startDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작 날짜", for: .normal)
        button.setImage(UIImage(named: "Calendar2"), for: .normal)
        button.tintColor = UIColor(named: "Black2")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(named: "Black2"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(showStartDatePicker), for: .touchUpInside)
        return button
    }()
        
    private lazy var endDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("끝난 날짜", for: .normal)
        button.setImage(UIImage(named: "Calendar2"), for: .normal)
        button.tintColor = UIColor(named: "Black2")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(named: "Black2"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(showEndDatePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var travelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 제목"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var travelTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.textColor = .lightGray
        textView.text = "| 여행 제목을 입력해주세요 (15자 이내)"
        textView.delegate = self
        return textView
    }()
    
    private lazy var dateButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        picker.isHidden = true
        return picker
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        picker.isHidden = true
        return picker
    }()
    
    private lazy var startLogButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("여행 기록 시작하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Not selected")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(startLog), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색할 국가를 입력하세요"
        return searchController
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        self.view.addSubview(startNavBar)
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }
    
    //MARK: - Set up UI
    private func setupUI() {
        setupDismissKeyboardGesture()

        view.addSubview(startNavBar)
        view.addSubview(addCountryButton)
        view.addSubview(titleLabel)
        view.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(createSpacer(height: 30))
        contentStackView.addArrangedSubview(travelPeriodLabel)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        contentStackView.addArrangedSubview(dateButtonStackView)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        dateButtonStackView.addArrangedSubview(startDateButton)
        dateButtonStackView.addArrangedSubview(endDateButton)
        
        contentStackView.addArrangedSubview(startDatePicker)
        contentStackView.addArrangedSubview(endDatePicker)
        contentStackView.addArrangedSubview(createSpacer(height: 20))
        contentStackView.addArrangedSubview(travelTitleLabel)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        contentStackView.addArrangedSubview(travelTextView)
        contentStackView.addArrangedSubview(createSpacer(height: 273))
        contentStackView.addArrangedSubview(startLogButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        startNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        
        addCountryButton.snp.makeConstraints { make in
            make.top.equalTo(startNavBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addCountryButton.snp.bottom).offset(15)
        }
        
        grayBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(grayBackgroundView.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        dateButtonStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        travelTextView.snp.makeConstraints { make in
            make.height.equalTo(50) // 원하는 높이 설정
        }
        
        startLogButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    //MARK: - Function
    private func createSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }
    
    @objc private func handleBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func showSearchController() {
        present(searchController, animated: true, completion: nil)
    }
    
    @objc private func showStartDatePicker() {
        startDatePicker.isHidden.toggle()
        endDatePicker.isHidden = true // 다른 date picker는 숨김
    }
    
    @objc private func showEndDatePicker() {
        endDatePicker.isHidden.toggle()
        startDatePicker.isHidden = true // 다른 date picker는 숨김
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: sender.date)
        
        if sender == startDatePicker {
            startDateButton.setTitle(dateString, for: .normal)
        } else if sender == endDatePicker {
            endDateButton.setTitle(dateString, for: .normal)
        }
    }
    
    @objc private func startLog() {
        // 여행 기록 시작하기 버튼 액션
        print("여행 기록 시작하기 버튼 클릭됨")
    }
    
    ///키보드 내리기
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
        
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - UITextViewDelegate
extension StartLogViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .darkText
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "| 여행 제목을 입력해주세요 (15자 이내)"
            textView.textColor = .lightGray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 현재 텍스트를 가져옴
        let currentText = textView.text ?? ""
        
        // 범위를 기반으로 새 텍스트 생성
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // 15자 제한
        return updatedText.count <= 15
    }
}

//MARK: - UISearchResultsUpdating
extension StartLogViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text, !keyword.isEmpty else {
            return
        }
        searchCities(keyword: keyword)
    }
    
    //MARK: - Alamofire request
    private func searchCities(keyword: String) {
        let url = "http://3.34.123.244:8080/search/cities"
        let parameters: [String: String] = ["keyword": keyword]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                // 전체 JSON 응답을 프린트
                print("전체 JSON 응답: \(value)")
                
                if let json = value as? [String: Any], let cities = json["cities"] as? [String] {
                    // cities 배열을 처리하고 UI를 업데이트하는 코드
                    print("도시 목록: \(cities)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}
