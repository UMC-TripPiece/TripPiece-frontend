//
//  LogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/5/24.
//

import UIKit
import SnapKit
import GoogleMaps

class LogViewController: UIViewController {

    // 상단 네비게이션 바
    private lazy var navBar: GradientNavigationBar = {
        let nav = GradientNavigationBar(title: "여행자님의 기록")
        return nav
    }()
    
    // 스크롤 뷰
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // 컨텐츠 뷰
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 구글 지도 뷰
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 37.5665, longitude: 126.9780, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.layer.cornerRadius = 16
        return mapView
    }()
    
    // "생성된 여행기" 라벨
    private let travelLogLabel: UILabel = {
        let label = UILabel()
        label.text = "생성된 여행기"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    // 생성된 여행기 리스트
    private lazy var travelLogCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 276, height: 196)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TravelLogCollectionViewCell.self, forCellWithReuseIdentifier: "travelLogCell")
        return collectionView
    }()
    
    //여행자님의 지난 여행 조각 라벨
    private let lastTravelLogLabel: UILabel = {
        let label = UILabel()
        label.text = "여행자님의 지난 여행 조각"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    // 필터 버튼
    private lazy var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10

        let filters: [(title: String, width: CGFloat)] = [
            ("전체", 60),
            ("사진", 79),
            ("동영상", 93),
            ("기타", 79) // 예시로 "기타"를 추가
        ]
        
        for filter in filters {
            let button = UIButton()
            button.setTitle(filter.title, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = .lightGray.withAlphaComponent(0.2)
            button.layer.cornerRadius = 16
            button.snp.makeConstraints { make in
                make.width.equalTo(filter.width)
                make.height.equalTo(32)
            }
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }()
    
    // 정렬 버튼
    private lazy var sortStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        let sortByNewestButton = UIButton()
        sortByNewestButton.setTitle("최신순", for: .normal)
        sortByNewestButton.setTitleColor(.systemBlue, for: .normal)
        sortByNewestButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sortByNewestButton.addTarget(self, action: #selector(sortByNewest), for: .touchUpInside)
        
        let sortByOldestButton = UIButton()
        sortByOldestButton.setTitle("오래된순", for: .normal)
        sortByOldestButton.setTitleColor(.lightGray, for: .normal)
        sortByOldestButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sortByOldestButton.addTarget(self, action: #selector(sortByOldest), for: .touchUpInside)
        
        stackView.addArrangedSubview(sortByNewestButton)
        stackView.addArrangedSubview(sortByOldestButton)
        
        return stackView
    }()
    
    // 여행 기록 리스트 (하단 스크롤 가능)
    private lazy var travelRecordTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TravelRecordTableViewCell.self, forCellReuseIdentifier: "travelRecordCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // 데이터 배열 (정렬을 위해 사용)
    private var travelRecords: [TravelRecord] = [
        TravelRecord(type: "사진", date: "2024.06.15 13:43", location: "다낭, 베트남"),
        TravelRecord(type: "영상", date: "2024.06.15 10:21", location: "다낭, 베트남"),
        TravelRecord(type: "사진", date: "2024.01.09 11:43", location: "후쿠오카, 일본"),
        TravelRecord(type: "영상", date: "2024.01.09 11:43", location: "후쿠오카, 일본"),
        TravelRecord(type: "메모", date: "2024.01.09 11:43", location: "후쿠오카, 일본")
    ]
    
    private var isSortedByNewest = true // 기본적으로 최신순 정렬
    
    // 추가 버튼 (플로팅 버튼)
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
        self.view.backgroundColor = .white
        setupUI()
    }
    
    //MARK: Set Up UI
    private func setupUI() {
        view.addSubview(navBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mapView)
        contentView.addSubview(travelLogLabel)
        contentView.addSubview(travelLogCollectionView)
        contentView.addSubview(lastTravelLogLabel)
        contentView.addSubview(filterStackView)
        contentView.addSubview(sortStackView)
        contentView.addSubview(travelRecordTableView)
        view.addSubview(addButton)
        
        setConstraints()
    }
    
    //MARK: Constraints 설정
    func setConstraints() {
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
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(211)
        }
        
        travelLogLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(21)
        }
        
        travelLogCollectionView.snp.makeConstraints { make in
            make.top.equalTo(travelLogLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.greaterThanOrEqualTo(196)
        }
        
        lastTravelLogLabel.snp.makeConstraints{ make in
            make.top.equalTo(travelLogCollectionView.snp.bottom).offset(39)
            make.leading.equalToSuperview().inset(21)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(lastTravelLogLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        sortStackView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        travelRecordTableView.snp.makeConstraints { make in
            make.top.equalTo(sortStackView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(63)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
    }
    
    // 정렬 메서드
    @objc private func sortByNewest() {
        isSortedByNewest = true
        travelRecords.sort { $0.date > $1.date }
        travelRecordTableView.reloadData()
    }
    
    @objc private func sortByOldest() {
        isSortedByNewest = false
        travelRecords.sort { $0.date < $1.date }
        travelRecordTableView.reloadData()
    }
    
    @objc private func startTravel() {
        let viewController = StartLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionView DataSource & Delegate
extension LogViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // 예시를 위해 5개의 셀을 표시합니다.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "travelLogCell", for: indexPath) as? TravelLogCollectionViewCell else {
            return UICollectionViewCell()
        }
        // 셀을 구성하는 코드 작성
        cell.configure(with: "여행기 \(indexPath.item + 1)", date: "2024.08.12~2024.08.17", location: "도쿄, 일본", status: "여행중")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 276, height: 196)
    }
}

//MARK: - UITableView DataSource & Delegate
extension LogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelRecordCell", for: indexPath) as? TravelRecordTableViewCell else {
            return UITableViewCell()
        }
        
        let record = travelRecords[indexPath.row]
        cell.configure(with: record.type, date: record.date, location: record.location)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // 각 셀의 높이
    }
}

// 데이터 모델
struct TravelRecord {
    let type: String
    let date: String
    let location: String
}

//MARK: - TravelLogCollectionViewCell
class TravelLogCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemPink.cgColor
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(locationLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .systemPink
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    func configure(with title: String, date: String, location: String, status: String) {
        titleLabel.text = title
        dateLabel.text = date
        locationLabel.text = location
        statusLabel.text = status
    }
}

//MARK: - TravelRecordTableViewCell
class TravelRecordTableViewCell: UITableViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(locationLabel)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with title: String, date: String, location: String) {
        titleLabel.text = title
        dateLabel.text = date
        locationLabel.text = location
        
        // 이미지 설정 (예: placeholder)
        thumbnailImageView.image = UIImage(named: "placeholder") // 필요시 실제 이미지로 교체
    }
}
