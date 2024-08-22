import UIKit
import SnapKit
import GoogleMaps

enum TravelItemType {
    case all
    case photo
    case video
    case music
    case memo
}

struct TravelItem {
    let type: TravelItemType
    let title: String
    let date: String
    let location: String
    let data: String // 이미지 이름 추가
}

struct TravelData: Decodable {
    let cityName: String
    let countryName: String
    let endDate: String
    let id: Int
    let startDate: String
    let status: String
    let thumbnail: String
    let title: String
}

struct ResponseData: Decodable {
    let result: [TravelData]
}

class TravelRecordViewController: UIViewController {
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    var allItems: [TravelItem] = [
        TravelItem(type: .photo, title: "사진", date: "2024.06.15 13:43", location: "후쿠오카, 일본", data: "city1"),
        TravelItem(type: .video, title: "영상", date: "2024.06.15 10.21", location: "런던, 영국", data: "city3"),
        TravelItem(type: .photo, title: "사진", date: "2024.01.09 11:43", location: "뉴욕, 미국", data: "city4"),
//        TravelItem(type: .music, title: "다낭, 베트남", date: "2024/08/17~2024/08/21", location: "다낭, 베트남", data: "city1"),
        TravelItem(type: .memo, title: "메모", date: "2024.01.09 11:43", location: "서울, 대한민국", data: "롯데월드 츄러스 가게 앞에서 류정란 성대모사를 했다"),
        TravelItem(type: .memo, title: "메모", date: "2024.01.09 11:43", location: "서울, 대한민국", data: "🥰🙀😡🥲")
    ]
    var filteredItems: [TravelItem] = []
    
    class FilterButton: UIButton {
        init(title: String, tag: Int, target: Any?, action: Selector) {
            super.init(frame: .zero)
            self.setTitle(title, for: .normal)
            self.setTitleColor(.black, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = 15
            self.tag = tag

            self.layer.borderColor = UIColor(hex: "#D8D8D8").cgColor
            self.layer.borderWidth = 1.0  // 원하는 테두리 두께로 설정

            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2 // 투명도 설정 (0.0 ~ 1.0)
            self.layer.shadowOffset = CGSize(width: 3, height: 3) // 섀도우의 위치 설정
            self.layer.shadowRadius = 4.0 // 섀도우의 블러 정도 설정
            
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            
            self.snp.makeConstraints { make in
                make.width.equalTo(80)
                make.height.equalTo(20)
            }
            
            self.addTarget(target, action: action, for: .touchUpInside)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func updateSelection(isSelected: Bool) {
            if isSelected {
                self.backgroundColor = UIColor(hex: "6644FF").withAlphaComponent(0.1)
                self.layer.borderColor = UIColor(hex: "6644FF").cgColor
                self.setTitleColor(UIColor(hex: "6644FF"), for: .normal)
            } else {
                self.backgroundColor = UIColor.white
                self.layer.borderColor = UIColor(hex: "#D8D8D8").cgColor  // 기본 테두리 색상
                self.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    private lazy var navBar: GradientNavigationBar = {
        let nav = GradientNavigationBar(title: "여행자님의 기록")
        return nav
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let stackView = UIStackView()
    
    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 37.5665, longitude: 126.9780, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        return mapView
    }()
    
    let tripSectionTitle = UILabel() // "생성된 여행기" 제목
    let TravelLogScrollView = UIScrollView()
    let TravelLogStackView = UIStackView()
    let historyTitle = UILabel() // "여행자의 지난 여행 조각" 제목
    // 필터 버튼을 위한 SegmentedControl
    
    let filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let allButton = FilterButton(title: "전체", tag: 0, target: self, action: #selector(filterButtonTapped(_:)))
    let photoButton = FilterButton(title: "📷 사진", tag: 1, target: self, action: #selector(filterButtonTapped(_:)))
    let videoButton = FilterButton(title: "🎬 영상", tag: 2, target: self, action: #selector(filterButtonTapped(_:)))
    let musicButton = FilterButton(title: "🎶 음악", tag: 3, target: self, action: #selector(filterButtonTapped(_:)))
    let memoButton = FilterButton(title: "✍🏻 메모", tag: 4, target: self, action: #selector(filterButtonTapped(_:)))
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus btn"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "Main")
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(startTravel), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTravelRecord()
        filteredItems = allItems
        setupView()
        setupConstraints() // 제약 조건을 별도의 함수로 설정

        addItemsToStackView(stackView: stackView, items: filteredItems)
    }
    
    func setupView() {
        contentView.backgroundColor = UIColor(hex: "FBFBFB")
        
        mapView.backgroundColor = .lightGray
        
        tripSectionTitle.text = "생성된 여행기"
        tripSectionTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        TravelLogScrollView.showsHorizontalScrollIndicator = false
        TravelLogStackView.distribution = .equalSpacing
        TravelLogStackView.axis = .horizontal
        TravelLogStackView.spacing = 15
        TravelLogStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        TravelLogStackView.isLayoutMarginsRelativeArrangement = true
    
        historyTitle.text = "여행자님의 지난 여행 조각"
        historyTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        filterStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        filterStackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.axis = .vertical  // 수직으로 뷰를 배치
        stackView.alignment = .fill  // 뷰의 너비를 부모에 맞춤
        stackView.distribution = .equalSpacing  // 각 뷰 간의 간격을 동일하게 설정
        stackView.spacing = 10  // 뷰 사이의 간격
        
        view.backgroundColor = .white
        
        view.addSubview(navBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(TravelLogScrollView)
        TravelLogScrollView.addSubview(TravelLogStackView)
        contentView.addSubview(mapView)
        contentView.addSubview(tripSectionTitle)
        contentView.addSubview(historyTitle)
        contentView.addSubview(filterScrollView)
        filterScrollView.addSubview(filterStackView)
        filterStackView.addArrangedSubview(allButton)
        filterStackView.addArrangedSubview(photoButton)
        filterStackView.addArrangedSubview(videoButton)
        filterStackView.addArrangedSubview(musicButton)
        filterStackView.addArrangedSubview(memoButton)
        contentView.addSubview(stackView)
        
        view.addSubview(addButton)
        
        updateSelectedFilterButton(selectedButton: allButton)
    }
    func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(107)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()  // scrollView의 너비는 고정
        }
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)  // 지도 영역의 높이
        }
        tripSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        TravelLogScrollView.snp.makeConstraints { make in
            make.top.equalTo(tripSectionTitle.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        TravelLogStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(240)  // 스크롤 뷰 내에서 스택 뷰의 높이 고정
        }
        historyTitle.snp.makeConstraints { make in
            make.top.equalTo(TravelLogScrollView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
        filterScrollView.snp.makeConstraints { make in
            make.top.equalTo(historyTitle.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        filterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(filterScrollView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-40)  // 마지막 요소이므로 아래 여백 설정
        }
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(63)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
    }
    
    func getTravelRecord() {
        guard let url = URL(string: "http://3.34.123.244:8080/travels") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "accept")
        if let refreshToken = getRefreshToken(){request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")}

        // Create a data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Handle response
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
            }
            
            // Handle data
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Response JSON: \(json)")
                    self.parseOngoingData(from: data)
                } else {
                    print("Invalid JSON data")
                }
            }
        }

        // Start the task
        task.resume()
    }
    
    func parseOngoingData(from jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(ResponseData.self, from: jsonData)
            
            DispatchQueue.main.async {
                // result 배열을 역순으로 순회
                responseData.result.reversed().forEach { data in
                    print("City: \(data.cityName), Country: \(data.countryName), Title: \(data.title), startDate: \(data.startDate), endDate: \(data.endDate)")
                    
                    let isOngoing = data.status == "ONGOING"
                    print(isOngoing)
                    self.addTravelLogCard(
                        imageURL: data.thumbnail,
                        title: data.title,
                        date: "\(data.startDate)~\(data.endDate)",
                        subtitle: "\(data.cityName), \(data.countryName)",
                        isONGOING: isOngoing
                    )
                }
            }
        } catch {
            print("JSON 파싱 중 오류 발생: \(error)")
        }
    }
    
//    func addTravelLogCard(imageURL: String, title: String, date: String, subtitle: String, isONGOING: Bool) {
//        let shadowView = UIView()
//            shadowView.backgroundColor = .clear
//            shadowView.layer.shadowColor = UIColor.black.cgColor
//            shadowView.layer.shadowOpacity = 0.2
//            shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
//            shadowView.layer.shadowRadius = 5
//            shadowView.layer.cornerRadius = 10
//        
//        let cardView = UIView()
//        cardView.backgroundColor = .black
//            cardView.layer.cornerRadius = 10
//            cardView.clipsToBounds = true
//        
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        cardView.addSubview(imageView)
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        // SDWebImage를 사용하여 이미지 URL을 로드
//        if let imageUrl = URL(string: imageURL) {  // imageName을 이미지 URL 문자열로 가정
//            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
//        }
//        
//        let overlayView = UIView()
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        cardView.addSubview(overlayView)
//        overlayView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        titleLabel.textColor = .white
//        overlayView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().inset(60)
//            make.left.equalToSuperview().offset(12)
//        }
//        
//        let isTravelButton = UIButton()
//        isTravelButton.setTitle("여행 중", for: .normal)
//        isTravelButton.backgroundColor = UIColor(hex: "FD2D69")
//        isTravelButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
//        isTravelButton.setTitleColor(.white, for: .normal)
//        isTravelButton.layer.cornerRadius = 8
//        isTravelButton.isHidden = true
//        overlayView.addSubview(isTravelButton)
//        isTravelButton.snp.makeConstraints { make in
//            make.height.equalTo(15)
//            make.left.equalTo(titleLabel.snp.right).offset(12)
//            make.centerY.equalTo(titleLabel.snp.centerY)
//            make.width.greaterThanOrEqualTo(40)// Adjust if profile image exists
//        }
//        
//        let dividerView = UIView()
//        dividerView.backgroundColor = UIColor.white
//        overlayView.addSubview(dividerView)
//        dividerView.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.left.equalToSuperview().offset(12)
//            make.right.equalToSuperview().offset(-12)
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//        }
//        
//        let dateIconView = UIImageView(image: UIImage(named: "dateIcon"))
//        dateIconView.contentMode = .scaleAspectFill
//        overlayView.addSubview(dateIconView)
//        dateIconView.snp.makeConstraints { make in
//            make.top.equalTo(dividerView.snp.bottom).offset(5)
//            make.width.height.equalTo(20)
//            make.left.equalToSuperview().offset(8)
//        }
//        
//        let dateLabel = UILabel()
//        dateLabel.text = date
//        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
//        dateLabel.textColor = .white
//        overlayView.addSubview(dateLabel)
//        dateLabel.snp.makeConstraints { make in
//            make.left.equalTo(dateIconView.snp.right).offset(8)
//            make.centerY.equalTo(dateIconView.snp.centerY)// Adjust if profile image exists
//        }
//        
//        let locationIconView = UIImageView(image: UIImage(named: "locationIcon"))
//        locationIconView.contentMode = .scaleAspectFill
//        overlayView.addSubview(locationIconView)
//        locationIconView.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(5)
//            make.width.height.equalTo(20)
//            make.left.equalToSuperview().offset(8)
//        }
//        
//        let subtitleLabel = UILabel()
//        subtitleLabel.text = subtitle
//        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
//        subtitleLabel.textColor = .white
//        overlayView.addSubview(subtitleLabel)
//        subtitleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(locationIconView.snp.centerY)
//            make.left.equalTo(locationIconView.snp.right).offset(8)
//        }
//        
//        shadowView.addSubview(cardView)
//        
//        TravelLogStackView.addArrangedSubview(shadowView)
//        shadowView.snp.makeConstraints { make in
//                make.width.equalTo(280)
//                make.height.equalTo(150)
//            }
//        cardView.snp.makeConstraints { make in
//                make.edges.equalToSuperview()  // cardView가 shadowView 안에서 꽉 차게 설정
//            }
//        
//        if isONGOING {
//            isTravelButton.isHidden = false
//            shadowView.layer.borderColor = UIColor(hex: "FD2D69").cgColor
//            shadowView.layer.shadowColor = UIColor(hex: "FD2D69").cgColor
//            shadowView.layer.shadowOpacity = 0.4 // 투명도 설정 (0.0 ~ 1.0)
//            shadowView.layer.shadowOffset = CGSize(width: 0, height: 0) // 섀도우의 위치 설정
//            shadowView.layer.shadowRadius = 5.0 // 섀도우의 블러 정도 설정
//            shadowView.layer.borderWidth = 1.0  // 원하는 테두리 두께로 설정
//            shadowView.snp.makeConstraints { make in
//                make.left.equalToSuperview().inset(16)
//            }
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OngoingTravelTapped))
//                shadowView.addGestureRecognizer(tapGesture)
//        }
//    }

    func addTravelLogCard(imageURL: String, title: String, date: String, subtitle: String, isONGOING: Bool) {
        let shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.cornerRadius = 10
        
        let cardView = UIView()
        cardView.backgroundColor = .black
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cardView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // SDWebImage를 사용하여 이미지 URL을 로드
        if let imageUrl = URL(string: imageURL) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cardView.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .white
        overlayView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.left.equalToSuperview().offset(12)
        }
        
        let isTravelButton = UIButton()
        isTravelButton.setTitle("여행 중", for: .normal)
        isTravelButton.backgroundColor = UIColor(hex: "FD2D69")
        isTravelButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        isTravelButton.setTitleColor(.white, for: .normal)
        isTravelButton.layer.cornerRadius = 8
        isTravelButton.isHidden = !isONGOING  // 수정: isONGOING 플래그에 따라 버튼 표시 여부 결정
        overlayView.addSubview(isTravelButton)
        isTravelButton.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(titleLabel.snp.right).offset(12)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.greaterThanOrEqualTo(40)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.white
        overlayView.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        let dateIconView = UIImageView(image: UIImage(named: "dateIcon"))
        dateIconView.contentMode = .scaleAspectFill
        overlayView.addSubview(dateIconView)
        dateIconView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(5)
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(8)
        }
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .white
        overlayView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(dateIconView.snp.right).offset(8)
            make.centerY.equalTo(dateIconView.snp.centerY)
        }
        
        let locationIconView = UIImageView(image: UIImage(named: "locationIcon"))
        locationIconView.contentMode = .scaleAspectFill
        overlayView.addSubview(locationIconView)
        locationIconView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(8)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        subtitleLabel.textColor = .white
        overlayView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationIconView.snp.centerY)
            make.left.equalTo(locationIconView.snp.right).offset(8)
        }
        
        shadowView.addSubview(cardView)
        TravelLogStackView.addArrangedSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(150)
        }
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if isONGOING {
            shadowView.layer.borderColor = UIColor(hex: "FD2D69").cgColor
            shadowView.layer.shadowColor = UIColor(hex: "FD2D69").cgColor
            shadowView.layer.shadowOpacity = 0.4
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
            shadowView.layer.shadowRadius = 5.0
            shadowView.layer.borderWidth = 1.0
            shadowView.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OngoingTravelTapped))
            shadowView.addGestureRecognizer(tapGesture)
        }
    }
    
    //MARK: - MyLog 이동
    @objc private func OngoingTravelTapped() {
        let MyLogVC = MyLogViewController()
        MyLogVC.hidesBottomBarWhenPushed = false
        navigationController?.pushViewController(MyLogVC, animated: true)
//        MyLogVC.modalPresentationStyle = .fullScreen
//        present(MyLogVC, animated: true, completion: nil)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        let selectedType: TravelItemType
        
        switch sender.tag {
        case 0:
            selectedType = .all
        case 1:
            selectedType = .photo
        case 2:
            selectedType = .video
        case 3:
            selectedType = .music
        case 4:
            selectedType = .memo
        default:
            selectedType = .all
        }
        if selectedType == .all {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { $0.type == selectedType }
        }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }  // 기존 뷰 제거
        addItemsToStackView(stackView: stackView, items: filteredItems)  // 새로운 뷰 추가
        
        updateSelectedFilterButton(selectedButton: sender as! FilterButton)
    }
    
    func updateSelectedFilterButton(selectedButton: FilterButton) {
        let buttons = [allButton, photoButton, videoButton, musicButton, memoButton]
        for button in buttons {
            button.updateSelection(isSelected: button == selectedButton)
        }
    }
    
    func addItemsToStackView(stackView: UIStackView, items: [TravelItem]) {
        for item in items {
            let itemView = UIView()
            itemView.backgroundColor = .white
            itemView.layer.cornerRadius = 10
            itemView.layer.shadowColor = UIColor.black.cgColor
            itemView.layer.shadowOpacity = 0.1
            itemView.layer.shadowOffset = CGSize(width: 0, height: 3)
            itemView.layer.shadowRadius = 4
            itemView.clipsToBounds = true
            
            let sideBar = UIView()
            sideBar.backgroundColor = .white
            itemView.addSubview(sideBar)
            sideBar.snp.makeConstraints { make in
                make.right.top.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.75)
            }
            
            let titleLabel = UILabel()
            titleLabel.text = item.title
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            titleLabel.textColor = .black
            sideBar.addSubview(titleLabel)
            
            if item.type == .memo {
                let memoContainerView = UIView()
                memoContainerView.backgroundColor = .lightGray
                itemView.addSubview(memoContainerView)

                    memoContainerView.snp.makeConstraints { make in
                        make.width.equalToSuperview().multipliedBy(0.4)
                        make.left.top.bottom.equalToSuperview()
                    }
                let memoLabel = UILabel()
                memoLabel.text = item.data
                memoLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
                memoLabel.textColor = .white
                memoLabel.numberOfLines = 0
                memoContainerView.addSubview(memoLabel)

                memoLabel.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(8)
                }
                titleLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(8)
                    make.leading.equalTo(memoContainerView.snp.trailing).offset(8)
                }
                sideBar.snp.makeConstraints { make in
                    make.width.equalToSuperview().multipliedBy(0.6)
                }
            } else if (item.type == .photo) || (item.type == .video) {
                let imageView = UIImageView()
                imageView.image = UIImage(named: item.data)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                itemView.addSubview(imageView)
                
                imageView.snp.makeConstraints { make in
                    make.width.equalToSuperview().multipliedBy(0.25)
                    make.left.top.bottom.equalToSuperview()
                }
                titleLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(8)
                    make.leading.equalTo(imageView.snp.trailing).offset(8)
                }
            } else {
                titleLabel.snp.makeConstraints { make in
                    make.top.leading.equalToSuperview().inset(8)
                }
            }
            
            let timeIconView = UIImageView(image: UIImage(named: "createdTimeIcon"))
            timeIconView.contentMode = .scaleAspectFill
            sideBar.addSubview(timeIconView)
            timeIconView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(5)
                make.width.height.equalTo(15)
                make.left.equalToSuperview().offset(8)
            }
            
            let timeLabel = UILabel()
            timeLabel.text = item.date
            timeLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.textColor = UIColor(hex: "636363")
            sideBar.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { make in
                make.left.equalTo(timeIconView.snp.right).offset(5)
                make.centerY.equalTo(timeIconView.snp.centerY)
            }

            let locationIconView = UIImageView(image: UIImage(named: "locationIcon"))
            locationIconView.contentMode = .scaleAspectFill
            sideBar.addSubview(locationIconView)
            locationIconView.snp.makeConstraints { make in
                make.top.equalTo(timeLabel.snp.bottom).offset(5)
                make.width.height.equalTo(15)
                make.left.equalToSuperview().offset(8)
            }
            
            let locationLabel = UILabel()
            locationLabel.text = item.location
            locationLabel.font = UIFont.systemFont(ofSize: 12)
            locationLabel.textColor = UIColor(hex: "636363")
            sideBar.addSubview(locationLabel)
            locationLabel.snp.makeConstraints { make in
                make.centerY.equalTo(locationIconView.snp.centerY)
                make.left.equalTo(locationIconView.snp.right).offset(5)
            }
            stackView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.height.equalTo(80)  // 각 itemView의 고정된 높이
            }
        }
    }
    @objc private func startTravel() {
        let viewController = StartLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

