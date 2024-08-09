//
//  MyLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit
import SnapKit

class MyLogViewController: UIViewController {
    //MARK: - UI
    ///상단뷰
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
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    private lazy var addRecordPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Main")
        return pageControl
    }()
        
    private let addRecordImages: [String] = ["example1", "example2", "example3", "example4"]
        
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
        
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        setupAddRecordViews()
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
        view.addSubview(topImageView)
        view.addSubview(userImageView)
        view.addSubview(userLabel)
        view.addSubview(mainTitleLabel)
        view.addSubview(calendarImageView)
        view.addSubview(calendarLabel)
        view.addSubview(recordLabel)
        view.addSubview(puzzleCollectionView)
        view.addSubview(addRecordLabel)
        view.addSubview(addRecordScrollView)
        view.addSubview(addRecordPageControl)
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.addArrangedSubview(button4)
        view.addSubview(buttonStackView)
        topImageView.addSubview(titleLabel)
               
        setupConstraints()
    }
    
    private func setupAddRecordViews() {
        for (index, imageName) in addRecordImages.enumerated() {
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            addRecordScrollView.addSubview(imageView)
                
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(UIScreen.main.bounds.width)
                make.leading.equalToSuperview().offset(CGFloat(index) * UIScreen.main.bounds.width)
            }
        }
        addRecordScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(addRecordImages.count), height: 150)
    }
    
    //MARK: - Snapkit
    private func setupConstraints() {
        topImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(235)
        }
            
        userImageView.snp.makeConstraints{ make in
            make.leading.equalTo(topImageView).inset(21)
            make.top.equalToSuperview().offset(50)
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
            make.top.equalToSuperview().offset(265)
            make.leading.equalToSuperview().offset(25)
        }
        
        puzzleCollectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(304)
            make.leading.equalToSuperview().offset(21)
            make.width.greaterThanOrEqualTo(348)
            make.height.lessThanOrEqualTo(58)
        }
         
        addRecordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(392)
            make.leading.equalToSuperview().offset(25)
        }
        
        addRecordScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(423)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(148)
        }
        
        addRecordPageControl.snp.makeConstraints { make in
            make.top.equalTo(addRecordScrollView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(additionalSafeAreaInsets).inset(160)
            make.centerX.equalTo(self.view)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        [button1, button2, button3, button4].forEach { button in
            button.snp.makeConstraints { make in
                make.width.height.greaterThanOrEqualTo(80)
            }
        }
    }
    
    //MARK: - Function
    @objc private func photoLogView() {
        let viewController = PhotoLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
        
    @objc private func videoLogView() {
        let viewController = VideoLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
        
    @objc private func memoLogView() {
        let viewController = MemoLogViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
//MARK: - Extension
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
}
