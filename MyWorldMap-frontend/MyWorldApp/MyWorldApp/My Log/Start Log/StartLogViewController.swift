//
//  StartLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/5/24.
//

import UIKit
import Alamofire

class StartLogViewController: UIViewController {
//    var travelInfo = TravelInfo(cityName: "도쿄", countryName: "일본", title: "잘 나오나 확인", startDate: nil, endDate: nil, thumbnail: UIImage(named: "dummy1"))
    
    var travelInfo = TravelInfo(cityName: nil,
                                countryName: nil,
                                title: nil,
                                startDate: nil,
                                endDate: nil,
                                thumbnail: nil)
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
        textView.isScrollEnabled = false
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
        button.backgroundColor = UIColor(named: "Cancel")
        button.layer.cornerRadius = 5
        button.isEnabled = false
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
    
    ///검색결과
    private var searchResults: [[String: String]] = []
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    ///사진 추가 버튼
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus photo"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.isHidden = true // 초기에는 숨겨진 상태
        button.alpha = 0.0 // 초기 알파값을 0으로 설정
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
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
        
        view.addSubview(addPhotoButton)
        
        view.addSubview(titleLabel)
        view.addSubview(grayBackgroundView)
        view.addSubview(searchTableView)
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
        searchTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalTo(grayBackgroundView.snp.top).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(startNavBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(15)
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
        let selectedDate = sender.date
        let dateString = dateFormatter.string(from: sender.date)
        
        if sender == startDatePicker {
            startDateButton.setTitle(dateString, for: .normal)
            travelInfo.updateInfo(startDate: selectedDate)
            updateStartLogButtonState()
        } else if sender == endDatePicker {
            endDateButton.setTitle(dateString, for: .normal)
            travelInfo.updateInfo(endDate: selectedDate)
            updateStartLogButtonState()
        }
    }
    
    ///사진 추가 버튼
    @objc private func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        UIBezierPath(ovalIn: rect).addClip()
        image.draw(in: rect)
        let circularImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return circularImage!
    }

    ///여행 시작 POST
    @objc private func startLog() {
        print("Travel Info: \(travelInfo)")
        
        NetworkManager.shared.postTravelData(
            cityName: travelInfo.cityName!,
            countryName: travelInfo.countryName!,
            title: travelInfo.title!,
            startDate: travelInfo.startDate!,
            endDate: travelInfo.endDate!,
            thumbnail: travelInfo.thumbnail!
        ) { result in
            switch result {
            case .success(let value):
                print("성공적으로 여행 데이터를 전송했습니다: \(value)")
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        // 현재 활성화된 scene의 window 접근
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = scene.windows.first,
                           let tabBarController = window.rootViewController as? TabBar {
                            
                            // MyLogViewController를 직접 인스턴스화해서 TabBar의 두 번째 탭으로 설정
                            let myLogVC = MyLogViewController()
                            let navigationController = UINavigationController(rootViewController: myLogVC)
                            navigationController.tabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: "My log"), tag: 2)
                            navigationController.tabBarItem.badgeValue = "여행중"
                            tabBarController.viewControllers?[1] = navigationController
                            
                            // 'My Log' 탭으로 이동
                            tabBarController.selectedIndex = 1
                        } else {
                            print("Error: TabBarController not found.")
                        }
                    }
                }
            case .failure(let error):
                print("여행 데이터 전송 실패: \(error.localizedDescription)")
                print("Travel Info: \(self.travelInfo)")
            }
        }
        
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
    //MARK: - 유효성 검사
    private func validateTravelInfo() -> Bool {
        // 모든 필드가 유효한 경우 true를 반환, 그렇지 않으면 false를 반환
        guard let cityName = travelInfo.cityName,
              let countryName = travelInfo.countryName,
              let title = travelInfo.title,
              let startDate = travelInfo.startDate,
              let endDate = travelInfo.endDate,
              let thumbnail = travelInfo.thumbnail else {
            return false
        }

        return !cityName.isEmpty &&
               !countryName.isEmpty &&
               !title.isEmpty &&
               startDate <= endDate && // Optional: Ensure start date is before or equal to end date
               thumbnail.size.width > 0 &&
               thumbnail.size.height > 0
    }
    private func updateStartLogButtonState() {
        // 여행 정보가 모두 채워져 있는지에 따라 버튼 활성화 여부를 결정
        if validateTravelInfo() {
            startLogButton.isEnabled = true
            startLogButton.backgroundColor = UIColor(named: "Main")
        } else {
            startLogButton.isEnabled = false
            startLogButton.backgroundColor = UIColor(named: "Cancel")
        }
    }

    //MARK: - Alamofire
    private func searchCities(keyword: String) {
        let url = "http://3.34.123.244:8080/search/cities"
        let parameters: [String: String] = ["keyword": keyword]
            
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("전체 JSON 응답: \(jsonString)")
                    if let json = value as? [String: Any], let cities = json["result"] as? [[String: Any]] {
                        self.searchResults = cities.map { cityData in
                            var cityDataDecoded = [String: String]()
                            cityData.forEach { key, value in
                                if let stringValue = value as? String {
                                    cityDataDecoded[key] = stringValue
                                }
                            }
                            return cityDataDecoded
                        }
                        self.searchTableView.isHidden = false
                        self.searchTableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @objc private func showAddphotoBtnController() {
        // 애니메이션 추가
        UIView.animate(withDuration: 0.3, animations: {
            // 크기를 60에서 38로 축소
            self.addCountryButton.transform = CGAffineTransform(scaleX: 0.63, y: 0.63) // 38/60 ≈ 0.63 비율로 축소
            
            // X축 위치를 오른쪽으로 52만큼 이동 (스냅킷 제약 조건을 업데이트)
            self.addCountryButton.snp.updateConstraints { make in
                make.centerX.equalToSuperview().offset(112)
            }

            self.view.layoutIfNeeded() // 레이아웃 변경 사항을 즉시 적용
        }, completion: { _ in
            // 추가적인 애니메이션 필요 시 여기에 추가
            self.addPhotoButton.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.addPhotoButton.alpha = 1.0
            }
        })
    }

}

//MARK: - UITextViewDelegate
extension StartLogViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .darkText
        }
        centerTextVertically(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "| 여행 제목을 입력해주세요 (15자 이내)"
            textView.textColor = .lightGray
        }
        centerTextVertically(textView)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 현재 텍스트를 가져옴
        let currentText = textView.text ?? ""
        travelInfo.updateInfo(title: currentText)
        updateStartLogButtonState()
        
        // 범위를 기반으로 새 텍스트 생성
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        centerTextVertically(textView)

        // 15자 제한
        return updatedText.count <= 15
    }
    func textViewDidChange(_ textView: UITextView) {
        centerTextVertically(textView)
    }
    private func centerTextVertically(_ textView: UITextView) {
        // 텍스트 높이와 텍스트뷰 높이를 비교하여 패딩 조정
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let topOffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        textView.contentOffset = CGPoint(x: 0, y: -positiveTopOffset)
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
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension StartLogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cityData = searchResults[indexPath.row]
        let cityName = cityData["cityName"] ?? ""
        let countryName = cityData["countryName"] ?? ""
        let countryImage = cityData["countryImage"] ?? ""
        
        cell.textLabel?.text = "\(countryImage) \(cityName), \(countryName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = searchResults[indexPath.row]
        print("선택된 도시: \(cityData)")
        let cityName = cityData["cityName"] ?? ""
        let countryName = cityData["countryName"] ?? ""
        let countryImage = cityData["countryImage"] ?? ""
        
        titleLabel.text = "\(countryImage) \(cityName), \(countryName)"
        travelInfo.updateInfo(cityName: "\(cityName)", countryName: "\(countryName)")
        updateStartLogButtonState()

        searchController.isActive = false
        searchTableView.isHidden = true
        showAddphotoBtnController()
    }
}
//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension StartLogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        // 이미지를 원형으로 만들기
        let circularImage = makeCircularImage(image: selectedImage, size: CGSize(width: 60, height: 60))
        travelInfo.updateInfo(thumbnail: selectedImage)
        updateStartLogButtonState()
        addPhotoButton.setImage(circularImage, for: .normal)
        addPhotoButton.layer.cornerRadius = 30
        addPhotoButton.clipsToBounds = true
//        addPhotoButton.snp.updateConstraints { make in
//            make.centerX.equalTo(addCountryButton.snp.centerX)
//        }
//        view.layoutIfNeeded()
    }
}
