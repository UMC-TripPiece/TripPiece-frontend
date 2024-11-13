//
//  NewWorldViewController.swift
//  MyWorldApp
//
//  Created by 김호성 on 2024.11.12.
//

import UIKit
import Alamofire
import Macaw

class MacawWorldViewController: UIViewController {
    
    // MARK: - Properties
    
    private var userName: String = ""
    private var profileImage: String = ""
    private var userSavedCountryColors: [String: String] = [:]
    private var colorVisitRecord: [Visit] = []
    private var cityVisitRecord: CountryCityData?
    private var visitedCountryNum: Int = 0 // 바꾸기
    private var visitedCityNum: Int = 0
    var userCountryColorsModel = UserCountryColorsModel() // viewModel 선언해주기
    
    private var searchResults: [[String: String]] = []
    
    
    
    // MARK: - UI Components
    
    private lazy var customNavBar: UIView = {
        let navBar = UIView()
        return navBar
    }()
    
    private lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행자님의 세계지도"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var navIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "puzzle icon"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mapView: MacawWorldView = {
        let svg = try! SVGParser.parse(resource: "BlankMapWorld")
        let map = Group(contents: [svg], place: .identity)
//        let mapView = WorldMacawView(frame: scrollView.frame)
        let mapView = MacawWorldView(frame: map.bounds!.toCG())
        mapView.delegate = self
        mapView.clipsToBounds = true
        return mapView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var customSearchBar: CustomSearchBar = {
        let searchBarVC = CustomSearchBar()
        searchBarVC.onTextDidChange = { [weak self] text in
            // 테두리 추가
            searchBarVC.searchBar.layer.borderWidth = 1.0
            searchBarVC.searchBar.layer.borderColor = UIColor(named: "Main")?.cgColor
//            self?.searchCities(keyword: text)
        }
        
        let searchBar = searchBarVC.searchBar
        searchBar.layer.cornerRadius = 5
        searchBar.layer.masksToBounds = true
        searchBar.backgroundImage = UIImage()  // 서치바의 기본 배경을 제거
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = UIColor(white: 1, alpha: 0.8)// 약간 투명한 배경 설정
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.1
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchBar.layer.shadowRadius = 10
        
        if let textField = searchBar.searchTextField as? UITextField {
            textField.backgroundColor = UIColor.clear
            textField.borderStyle = .none
            textField.layer.cornerRadius = 12
            textField.layer.masksToBounds = true
        }

        return searchBarVC
    }()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        tableView.backgroundColor = .clear
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.1
        tableView.layer.shadowOffset = CGSize(width: 0, height: 4)
        tableView.layer.shadowRadius = 15
        
        return tableView
    }()
    
    private lazy var searchTableViewHeightConstraint = searchTableView.heightAnchor.constraint(equalToConstant: 0)
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupDismissKeyboardGesture()
        setupUI()
        
        getColoredCountries { [weak self] in
            DispatchQueue.main.async {
                self?.userCountryColorsModel.userSavedCountryColors = self?.userSavedCountryColors ?? [:]
            }
        }
        
        getCountryCityCounts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        
        scrollView.maximumZoomScale = scrollView.bounds.height / mapView.map.bounds!.h * 10
        scrollView.minimumZoomScale = scrollView.bounds.height / mapView.map.bounds!.h
        scrollView.zoomScale = scrollView.minimumZoomScale
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 레이아웃이 변경될 때 그라디언트 레이어의 프레임을 업데이트
        if let gradientLayer = customNavBar.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = customNavBar.bounds
        }
    }
    
    // MARK: - Setup UI
    
    @objc func dismissSearch() {
        // searchBar 포커스 해제
        customSearchBar.resignFirstResponder()
        
        // searchTableView 숨기기
        searchTableView.isHidden = true
    }
    
    // GestureRecognizer가 특정 뷰에 대한 터치를 무시하게 하는 메서드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // searchTableView와 그 내부의 셀에 터치된 경우 제스처 무시
        if let viewTouched = touch.view, viewTouched.isDescendant(of: searchTableView) {
            return false
        }
        return true
    }
    
    private func setupUI() {
        
        view.addSubview(customNavBar)
        customNavBar.addSubview(navIconImageView)
        customNavBar.addSubview(navTitleLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(mapView)
        
        view.addSubview(customSearchBar.view)
        view.addSubview(searchTableView)
        
        addChild(customSearchBar)
        customSearchBar.didMove(toParent: self)
        
        setupConstraints()
        addGradientLayer(to: customNavBar)
    }
    
    private func setUpBadgeView() {
        // 기존의 지도 및 UI 요소가 추가된 후 아래에 배지 뷰를 추가합니다.
        let floatingBadgeView = FloatingBadgeView()
        floatingBadgeView.updateProfile(userName: userName)
        floatingBadgeView.updateProfileImage(with: profileImage)
        floatingBadgeView.updateSubtitleLabel(countryNum: visitedCountryNum, cityNum: visitedCityNum)
        floatingBadgeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingBadgeView)
                
        
        floatingBadgeView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(42)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(111)
            make.centerX.equalToSuperview()
        }
    }
    

    
    private func setupConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.top)  // 상태바까지 포함하도록 top을 view의 top에 맞춤
            make.height.equalTo(120)  // 상태바를 포함한 전체 높이
        }
        
        navIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(customNavBar.snp.leading).offset(16)
            make.bottom.equalTo(customNavBar.snp.bottom).offset(-15)
            make.width.height.equalTo(24)
        }

        navTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(navIconImageView.snp.trailing).offset(8)
            make.centerY.equalTo(navIconImageView)
        }

        customSearchBar.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(customNavBar.snp.bottom).offset(10)
            make.height.equalTo(48)
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.view.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchTableViewHeightConstraint.isActive = true // 높이 제약 활성화
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(mapView.map.bounds!.w)
            print(mapView.map.bounds!.w)
            make.height.equalTo(mapView.map.bounds!.h)
            print(mapView.map.bounds!.h)
        }
        
        
    }
    
    private func addGradientLayer(to navBar: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: "gra1")?.cgColor ?? UIColor.blue.cgColor,
            UIColor(named: "gra2")?.cgColor ?? UIColor.red.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = navBar.bounds
        navBar.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // WorldViewController의 UI를 업데이트하는 메서드
    func updateWorldViewUI(with country: CountryEnum) {
        let scrollViewSize = scrollView.bounds.size
        guard let countryBounds = mapView.getCountryBounds(country: country) else { return }
        
        let zoomScaleX = scrollViewSize.width / countryBounds.width
        let zoomScaleY = scrollViewSize.height / countryBounds.height
        let newZoomScale = min(zoomScaleX, zoomScaleY, scrollView.maximumZoomScale)
        
        scrollView.setZoomScale(newZoomScale, animated: true)
        
        mapView.contentScaleFactor = scrollView.zoomScale
        
        let offsetX = (countryBounds.midX * newZoomScale) - (scrollViewSize.width / 2)
        let offsetY = (countryBounds.midY * newZoomScale) - (scrollViewSize.height / 2)
        
        let newContentOffset = CGPoint(x: max(offsetX, 0), y: max(offsetY, 0))
        scrollView.setContentOffset(newContentOffset, animated: true)
//        print("scrollview\(scrollViewSize)\ncountryBounds\(countryBounds)\nzoomScale\(newZoomScale)\noffset\(newContentOffset)")
    }
    
    
    func mergeToVisitCities(cityIdArray: [Int]?, countryColors: [Visit]) -> [VisitCities] {
        guard let cityIdArray = cityIdArray else { return [] }
        var resultArray: [VisitCities] = []
        
        // 미리 countryColors를 countryCode를 키로 하여 Dictionary로 변환
        let countryColorsDict = Dictionary(uniqueKeysWithValues: countryColors.map { ($0.countryCode, $0.color) })
        
        for cityId in cityIdArray {
            guard
                let cityName = cityIds.first(where: { $0.value == cityId })?.key,
                let countryName = findCountry[cityId],
                let countryCode = countryCodes[countryName],
                let color = countryColorsDict[countryCode]
            else { continue }
            
            let visitCityRecord = VisitCities(cityId: cityId, cityName: cityName, countryName: countryName, color: color)
            resultArray.append(visitCityRecord)
        }
        
        return resultArray
    }
    
    // MARK: - Networking
    
    
    func getUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "id")
    }

    
    
    
    //userid 개별적으로 받기 수정 후 ver.
    private func getColoredCountries(completion: @escaping () -> Void) {
        guard let userId = getUserId() else { return }
        
        let url = "http://3.34.111.233:8080/api/maps/\(userId)"
        
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // JSON 데이터를 ApiResponse 구조체로 디코딩
                    let apiResponse = try JSONDecoder().decode(APIMapsResponse.self, from: data)
                    print("ColoredCountriesData - Success: \(apiResponse.success)")
                    print("Message: \(apiResponse.message)")
                    
                    self.colorVisitRecord = apiResponse.data
                    
                    // data 배열의 각 방문 기록 출력
                    for visit in apiResponse.data {
                        //print("Map ID: \(visit.mapId), City ID: \(visit.cityId), City Name: \(visit.cityName), Country Code: \(visit.countryCode), Color: \(visit.color)")
                        //print("userid: \(visit.userId), countryCode: \(visit.countryCode), color: \(visit.color)")
                        DispatchQueue.main.async {
                            self.userSavedCountryColors[visit.countryCode] = visit.color
                        }
                            
                    }
                    // 데이터가 모두 로드된 후에 completion 호출
                    completion()
                } catch let error {
                    print("Failed to decode JSON with error: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    
    
    // NotificationCenter에서 호출할 메서드
    @objc private func handleDidPostMapDataNotification(_ notification: Notification) {
        getColoredCountries { [weak self] in
            DispatchQueue.main.async {
                self?.userCountryColorsModel.userSavedCountryColors = self?.userSavedCountryColors ?? [:]
                self?.getCountryCityCounts()
            }
        }
        
        
    }
    
    
    
    private func getCountryCityCounts() {
        guard let userId = getUserId() else { return }

        let url = "http://3.34.111.233:8080/api/maps/stats/\(userId)"
        
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // JSON 데이터를 ApiResponse 구조체로 디코딩
                    let apiResponse = try JSONDecoder().decode(APIStatsResponse.self, from: data)
                    print("CountryCityData - Success: \(apiResponse.success)")
                    print("Message: \(apiResponse.message)")
                    
                    self.cityVisitRecord = apiResponse.data
                    
                    // data 배열의 각 방문 기록 출력
                    print("CountryCount: \(apiResponse.data.countryCount), CityCount: \(apiResponse.data.cityCount), countryCodes: \(apiResponse.data.countryCodes), cityIds: \(apiResponse.data.cityIds)")
                    DispatchQueue.main.async {
                        self.userName = apiResponse.data.nickname
                        self.profileImage = apiResponse.data.profileImg
                        self.visitedCountryNum = apiResponse.data.countryCount
                        self.visitedCityNum = apiResponse.data.cityCount
                        self.setUpBadgeView()
                    }
                            
                    // 데이터가 모두 로드된 후에 completion 호출 -> api 반영돼서 화면에 뜨게 하려면 필요
                    //completion()
                } catch let error {
                    print("Failed to decode JSON with error: \(error)")
                }
                
                
                /*if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }*/
                // 나머지 디코딩 코드는 동일
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    
    
    
    

    

        private func searchCities(keyword: String) {
            let url = "http://3.34.111.233:8080/search/cities"
            let parameters: [String: String] = ["keyword": keyword]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        //print("전체 JSON 응답: \(jsonString)")
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
                            self.updateSearchTableViewHeight() // 테이블 뷰 높이 업데이트
                            self.searchTableView.isHidden = self.searchResults.isEmpty
                            self.searchTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
        }
        
        


        
        
        

    
    
    
    // 검색 결과 수에 따라 테이블 뷰 높이를 업데이트
    private func updateSearchTableViewHeight() {
        let rowHeight: CGFloat = 48.0 // 각 행의 높이
        let maxVisibleRows = 4 // 표시할 최대 행 수
        let visibleRows = min(searchResults.count, maxVisibleRows)
        let newHeight = (CGFloat(visibleRows) * rowHeight) + 55
        searchTableViewHeightConstraint.constant = newHeight
        UIView.animate(withDuration: 0.3) { // 애니메이션으로 높이 변경
            self.view.layoutIfNeeded()
        }
    }
    

    
    
    
    // MARK: - Functions
    func navigateToDetailView() {
        let dataToSend = mergeToVisitCities(cityIdArray: cityVisitRecord?.cityIds, countryColors: colorVisitRecord)
        print(dataToSend)
        let visitRecordsViewController = VisitRecordsViewController()
        visitRecordsViewController.visitRecords = dataToSend
        navigationController?.pushViewController(visitRecordsViewController, animated: true)
    }
    
    
    
    
    
    
    // 옵저버 제거 (deinit에서 옵저버 해제)
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didPostMapData, object: nil)
    }
    
    
    // 키보드 숨기기 제스처 설정
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MacawWorldViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // 첫 번째 셀을 "검색 결과:"로 표시
            let cell = UITableViewCell(style: .default, reuseIdentifier: "HeaderCell")
            cell.textLabel?.text = "검색 결과"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textColor = .black
            cell.backgroundColor = UIColor(white: 1, alpha: 0.8)
            return cell
        } else {
            // 나머지 셀은 검색 결과를 표시
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }
                
            let cityData = searchResults[indexPath.row - 1]  // -1을 하여 첫 번째 셀을 건너뜁니다.
            let cityName = cityData["cityName"] ?? ""
            let countryName = cityData["countryName"] ?? ""
            let countryImage = cityData["countryImage"] ?? ""
                
            cell.configure(cityName: cityName, countryName: countryName, countryImage: countryImage)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55  // 첫 번째 셀의 높이를 50으로 고정
        } else {
            return 48 // 나머지 셀의 높이는 커스텀 셀에 의해 결정됨
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = searchResults[indexPath.row - 1]
        
        customSearchBar.searchBar.text = cityData["cityName"]
        searchTableView.isHidden = true
        
        let selectedCityViewController = SelectedCityViewController()
        selectedCityViewController.cityData = cityData
        
        // TODO: Macaw로 변환하면서 수정 못한 것
//        updateWorldViewUI(with: cityData["countryName"] ?? "한국")
        
        
        // 모달로 표시할 때 기존 뷰 컨트롤러를 배경에 반투명하게 보이도록 설정
        selectedCityViewController.modalPresentationStyle = .overCurrentContext
        selectedCityViewController.modalTransitionStyle = .crossDissolve // 부드러운 전환을 위해
        // 모달로 뷰 컨트롤러를 표시
        present(selectedCityViewController, animated: true, completion: nil)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)  // 스크롤을 시작할 때 키보드 내리기
        searchTableView.isHidden = true
    }
}



extension MacawWorldViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("zoom")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll")
        print(scrollView.contentOffset)
        print(scrollView.contentSize)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // 확대 끝나고 해상도 높이기
        DispatchQueue.global().async { [weak self] in
            DispatchQueue.main.async {
                self?.mapView.contentScaleFactor = scrollView.zoomScale
            }
        }
    }
}


extension MacawWorldViewController: MapDelegate {
    
    func onClick(country: CountryEnum?) {
        if let country = country {
            // 나라 클릭됐을 때, 구현할 것
            print("onClicked\nID: \(country.rawValue), name: \(country.name), flag: \(country.emoji)")
            updateWorldViewUI(with: country)
        } else {
            // 바다 클릭됐을 때, 구현할 것
            print("onClickedSea")
        }
    }
}
