//
//  MyLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit
import SnapKit

extension UIViewController {
    func postPuzzleCompletion(index: Int) {
        NotificationCenter.default.post(name: .puzzlePieceCompleted, object: index)
    }
}

class MyLogViewController: UIViewController {
    
    //MARK: - UI
    ///상단뷰
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        // xmark 아이콘 설정
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        // 버튼의 아이콘 색상을 흰색으로 설정
        button.tintColor = .white
        // 버튼의 액션 설정
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        // 버튼에 제약 조건 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
        
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Log Background")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowRadius = 4
        return imageView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dummy1")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "여행자"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "연우와 우정여행"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도쿄, 일본\n오늘은 여행 1일차예요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Calendar")
        return imageView
    }()
    
    private lazy var calendarLabel: UILabel = {
        let label = UILabel()
        label.text = "24.08.12~24.08.16"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    ///기록 현황
    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.text = "기록 현황"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "Main")
        return label
    }()
        
    var puzzleData: [PuzzleItem] = PuzzleData.dataList
    private lazy var puzzleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.clipsToBounds = false
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 10
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOpacity = 0.2
        collectionView.dataSource = self
        collectionView.register(PuzzleViewCell.self, forCellWithReuseIdentifier: PuzzleViewCell.identifier)
        return collectionView
    }()
    
    ///기록 남기기
    private lazy var addRecordLabel: UILabel = {
        let label = UILabel()
        label.text = "기록 남기기"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "Main")
        return label
    }()
    private lazy var addRecordScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false  // 수직 스크롤 인디케이터 숨기기
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    private lazy var addRecordPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = addRecordImages.count
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Main")
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        return pageControl
    }()
        
    private let addRecordImages: [String] = ["mission1", "mission2", "mission3"]
        
    ///버튼
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button1"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(photoLogView), for: .touchUpInside)
        return button
    }()
        
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button2"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(videoLogView), for: .touchUpInside)
        return button
    }()
    
    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button3"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
        
    private lazy var button4: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button4"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(memoLogView), for: .touchUpInside)
        return button
    }()
    
    ///여행종료
    private lazy var endTripButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행 종료", for: .normal)
        button.backgroundColor = UIColor(named: "Finish")
        button.setTitleColor(.systemRed, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(endTrip), for: .touchUpInside)
        return button
    }()
        
    var travelId: Int?
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePuzzlePieceCompletion), name: .puzzlePieceCompleted, object: nil)

        self.view.backgroundColor = .white
        setupUI()
        setupAddRecordViews()
        fetchOngoingTravelId()

    }
    
    //MARK: - Stack
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4.5
        return stackView
    }()
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(topImageView)
        view.addSubview(userImageView)
        view.addSubview(userLabel)
        view.addSubview(mainTitleLabel)
        view.addSubview(calendarImageView)
        view.addSubview(calendarLabel)
        view.addSubview(closeButton)
        
        contentView.addSubview(recordLabel)
        contentView.addSubview(puzzleCollectionView)
        contentView.addSubview(addRecordLabel)
        contentView.addSubview(addRecordScrollView)
        contentView.addSubview(addRecordPageControl)
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.addArrangedSubview(button4)
        contentView.addSubview(buttonStackView)
        contentView.addSubview(endTripButton)
        
        topImageView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupAddRecordViews() {
        addRecordScrollView.delegate = self  // 델리게이트 설정
        
        var lastContainerView: UIView?

        for (index, imageName) in addRecordImages.enumerated() {
            let containerView = UIView()
            containerView.backgroundColor = .clear
            addRecordScrollView.addSubview(containerView)

            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.1
            imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = false
            containerView.addSubview(imageView)

            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index

            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()  // 컨테이너 뷰를 스크롤 뷰에 맞춤
                make.height.equalTo(addRecordScrollView) // 스크롤 뷰 높이에 맞춤
                make.width.equalTo(addRecordScrollView.snp.width).offset(-20)  // 좌우 간격 추가
                if let lastContainerView = lastContainerView {
                    make.leading.equalTo(lastContainerView.snp.trailing).offset(20)
                } else {
                    make.leading.equalToSuperview().offset(10)
                }
            }

            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)  // 이미지뷰 상단 패딩
                make.bottom.equalToSuperview().offset(-10)  // 이미지뷰 하단 패딩
                make.leading.trailing.equalToSuperview()  // 좌우는 컨테이너 뷰에 맞춤
            }

            lastContainerView = containerView
        }

        if let lastContainerView = lastContainerView {
            lastContainerView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    }
    
    //MARK: - Snapkit
    private func setupConstraints() {
        closeButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(56)
            make.trailing.equalToSuperview().inset(25)
        }
        
        topImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(235)
        }
            
        userImageView.snp.makeConstraints{ make in
            make.leading.equalTo(topImageView).inset(21)
            make.top.equalToSuperview().offset(50)
            make.width.height.equalTo(20)
        }
        
        userLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(49)
            make.top.equalToSuperview().offset(52)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalTo(topImageView).offset(30)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(26)
            make.leading.equalTo(topImageView).offset(30)
        }
        
        calendarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(192)
            make.leading.equalTo(topImageView).inset(30)
            make.width.lessThanOrEqualTo(18)
            make.height.lessThanOrEqualTo(18)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(195)
            make.leading.equalTo(calendarImageView).offset(22)
        }
    
        recordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(25)
        }
        
        puzzleCollectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(69)
            make.leading.equalToSuperview().offset(21)
            make.width.greaterThanOrEqualTo(348)
            make.height.lessThanOrEqualTo(58)
        }
         
        addRecordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(157)
            make.leading.equalToSuperview().offset(25)
        }
        
        addRecordScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(188)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(148)
        }
        
        addRecordPageControl.snp.makeConstraints { make in
            make.top.equalTo(addRecordScrollView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(390)
            make.centerX.equalTo(self.view)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        [button1, button2, button3, button4].forEach { button in
            button.snp.makeConstraints { make in
                make.width.height.greaterThanOrEqualTo(80)
            }
        }
        
        ///추가
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
                
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(620)
        }
        
        endTripButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-41)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - Function
    
    @objc private func closeButtonTapped() {
        // 네비게이션 스택에서 이전 화면으로 돌아가기
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let offset = CGFloat(currentPage) * UIScreen.main.bounds.width
        addRecordScrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    @objc private func photoLogView() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let viewController = PhotoLogViewController(travelId: travelId)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
        
    @objc private func videoLogView() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let viewController = VideoLogViewController(travelId: travelId)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
        
    @objc private func memoLogView() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let viewController = MemoLogViewController(travelId: travelId)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc private func endTrip() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        // 이동할 뷰 컨트롤러 생성
        let endTripAlertViewController = EndTripAlertViewController(travelId: travelId)
        // 모달로 표시할 때 기존 뷰 컨트롤러를 배경에 반투명하게 보이도록 설정
        endTripAlertViewController.modalPresentationStyle = .overCurrentContext
        endTripAlertViewController.modalTransitionStyle = .crossDissolve // 부드러운 전환을 위해
        // 화면 이동
        self.present(endTripAlertViewController, animated: true, completion: nil)
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view else { return }
        let tappedIndex = tappedImageView.tag
        
        switch tappedIndex {
        case 0:
            // "mission1"을 클릭했을 때 이동할 페이지
            navigateToMission1Page()
        case 1:
            // "mission2"를 클릭했을 때 이동할 페이지
            navigateToMission2Page()
        case 2:
            // "mission3"를 클릭했을 때 이동할 페이지
            navigateToMission3Page()
        default:
            break
        }
    }
    ///여기에 이동경로 추가
    //MARK: - 이동경로 추가
    private func navigateToMission1Page() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let mission1VC = SelfieLogViewController(travelId: travelId)
        mission1VC.modalPresentationStyle = .fullScreen
        self.present(mission1VC, animated: true, completion: nil)
    }
        
    private func navigateToMission2Page() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let mission2VC = LiveVideoLogViewController(travelId: travelId)
        mission2VC.modalPresentationStyle = .fullScreen
        self.present(mission2VC, animated: true, completion: nil)
    }
        
    private func navigateToMission3Page() {
        guard let travelId = travelId else {
            print("Travel ID가 없습니다.")
            return
        }
        let mission3VC = EmojiLogViewController(travelId: travelId)
        mission3VC.modalPresentationStyle = .fullScreen
        self.present(mission3VC, animated: true, completion: nil)
    }
    
    //MARK: - GET으로 UI 업데이트
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    func updateUI() {
        guard let url = URL(string: "http://3.34.123.244:8080/mytravels") else { return }
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
                       let profileImg = result["profileImg"] as? String,
                       let profileImgURL = URL(string: profileImg),
                       let nickname = result["nickname"] as? String,
                       let title = result["title"] as? String,
                       let cityName = result["cityName"] as? String,
                       let countryName = result["countryName"] as? String,
                       let startDate = result["startDate"] as? String,
                       let endDate = result["endDate"] as? String,
                       let dayCount = result["dayCount"] as? Int,
                       let memoNum = result["memoNum"] as? Int,
                       let pictureNum = result["pictureNum"] as? Int,
                       let videoNum = result["videoNum"] as? Int {
                        DispatchQueue.main.async {
                            self.userImageView.sd_setImage(with: profileImgURL, placeholderImage: UIImage(named: "dummy1"))
                            self.userImageView.layer.cornerRadius = 10
                            self.userLabel.text = "\(nickname)"
                            self.titleLabel.text = "\(title)"
                            self.mainTitleLabel.text = "\(cityName), \(countryName)\n오늘은 여행 \(dayCount)일차예요!"
                            self.calendarLabel.text = "\(startDate)~\(endDate)"
                            PuzzleData.dataList[3].puzzleCount = memoNum
                            PuzzleData.dataList[0].puzzleCount = pictureNum
                            PuzzleData.dataList[1].puzzleCount = videoNum
                            self.puzzleData = PuzzleData.dataList
                            self.puzzleCollectionView.reloadData()
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    //MARK: - TravelId 반환
    private func fetchOngoingTravelId() {
        guard let url = URL(string: "http://3.34.123.244:8080/travels") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "accept")
        if let refreshToken = getRefreshToken() {
            request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching travelId: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let resultArray = json["result"] as? [[String: Any]] {
                    // 진행 중인 여행을 찾아 travelId를 설정
                    if let ongoingTravel = resultArray.first(where: { $0["status"] as? String == "ONGOING" }),
                       let travelId = ongoingTravel["id"] as? Int {
                        self.travelId = travelId
                        print("TravelId found: \(travelId)")
                    }
                }
            } catch {
                print("Error decoding travel data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
//MARK: - Extension
extension MyLogViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        addRecordPageControl.currentPage = currentPage
    }
}
extension MyLogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleViewCell.identifier, for: indexPath) as? PuzzleViewCell else {
            return UICollectionViewCell()
        }
        let model = puzzleData[indexPath.row]
        cell.addData(model: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 화면 너비에 따라 셀 크기를 동적으로 조정하여 가운데 정렬
        let totalInset: CGFloat = 17 * 2
        let totalSpacing: CGFloat = 14 * CGFloat(puzzleData.count - 1)
        let availableWidth = collectionView.frame.width - totalInset - totalSpacing
        let itemWidth = availableWidth / CGFloat(puzzleData.count)
        return CGSize(width: itemWidth, height: 58)
    }
    
    @objc private func handlePuzzlePieceCompletion(notification: Notification) {
        if let index = notification.object as? Int {
            puzzleData[index].puzzleCount += 1
            puzzleCollectionView.reloadData()
        }
    }
}
