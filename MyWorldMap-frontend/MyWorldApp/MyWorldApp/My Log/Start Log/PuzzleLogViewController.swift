//
//  PuzzleLogViewController.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/20/24.
//

import UIKit

class PuzzleLogViewController: UIViewController, UIScrollViewDelegate {
    

    // ScrollView 생성
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // StackView 생성
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "연우와 우정여행"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var puzzlesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puzzlesImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        
        // 달력 이미지
        let dateImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "calendarImage")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 18),
                imageView.heightAnchor.constraint(equalToConstant: 18)
            ])
            return imageView
        }()
        
        // 날짜 레이블
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = "24.08.12~24.08.16"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(named: "Main")
            return label
        }()
        
        stackView.addArrangedSubview(dateImageView)
        stackView.addArrangedSubview(dateLabel)
        
        return stackView
    }()

    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.addArrangedSubview(navTitleLabel)
        stackView.addArrangedSubview(dateStackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    
    
    
    private lazy var initialCustomNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(puzzlesImageView)
        view.addSubview(titleStackView)
        
        NSLayoutConstraint.activate([
            
            puzzlesImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            puzzlesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            puzzlesImageView.widthAnchor.constraint(equalToConstant: 105.72),
            puzzlesImageView.heightAnchor.constraint(equalToConstant: 25.5),
            
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleStackView.topAnchor.constraint(equalTo: puzzlesImageView.bottomAnchor, constant: 30)
        ])
        
        return view
    }()
    
    
    
    
    private lazy var scrolledCustomNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12"
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main")

        let dayLabel = UILabel()
        dayLabel.text = "1일차"
        dayLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        dayLabel.textAlignment = .center
        dayLabel.textColor = UIColor(named: "Black1")
        
        let arrowImageView1 = UIImageView()
        let arrowImageView2 = UIImageView()
        arrowImageView1.image = UIImage(named: "arrowImage2")
        arrowImageView2.image = UIImage(named: "arrowImage")
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
            
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dayLabel)
        view.addSubview(stackView)
        view.addSubview(arrowImageView1)
        view.addSubview(arrowImageView2)
            
        stackView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView1.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            
            arrowImageView1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            arrowImageView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            arrowImageView1.widthAnchor.constraint(equalToConstant: 8),
            arrowImageView1.heightAnchor.constraint(equalToConstant: 17),
            
            arrowImageView2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            arrowImageView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            arrowImageView2.widthAnchor.constraint(equalToConstant: 8),
            arrowImageView2.heightAnchor.constraint(equalToConstant: 17)
        ])
        return view
    }()

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // ScrollView에 StackView 추가
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        // 기존 navigation Bar 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupCustomNavBar()
        
        // ScrollView Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 185), // 수정된 부분
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // StackView Constraints (ScrollView에 맞게)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])


        // 스크롤 가능한 내용 추가 (여기서는 예시로 label과 imageView를 사용)
        addContentToStackView()
        addContentToStackView()
        setupConstraints()
    }
    
    
    private func setupCustomNavBar() {
        view.addSubview(initialCustomNavBar)
        view.addSubview(scrolledCustomNavBar)
                
        initialCustomNavBar.translatesAutoresizingMaskIntoConstraints = false
        scrolledCustomNavBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // initialCustomNavBar constraints
            initialCustomNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            initialCustomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            initialCustomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            initialCustomNavBar.heightAnchor.constraint(equalToConstant: 185),

            // scrolledCustomNavBar constraints
            scrolledCustomNavBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrolledCustomNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            scrolledCustomNavBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrolledCustomNavBar.heightAnchor.constraint(equalToConstant: 185)
        ])

        // 초기 상태 설정
        initialCustomNavBar.isHidden = false
        scrolledCustomNavBar.isHidden = true
    }
    

    private func addContentToStackView() {
        
        stackView.spacing = 0
        
        
        stackView.addArrangedSubview(backgroundView1)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView2)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView3)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView4)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView5)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView6)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView7)
        stackView.addArrangedSubview(createSeparatorView())
        stackView.addArrangedSubview(backgroundView8)
        

    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY > 200 {
            // 스크롤이 200 이상일 때 scrolledCustomNavBar를 표시하고 initialCustomNavBar를 숨김
            initialCustomNavBar.isHidden = true
            scrolledCustomNavBar.isHidden = false
        } else {
            // 스크롤이 200 이하일 때 initialCustomNavBar를 표시하고 scrolledCustomNavBar를 숨김
            initialCustomNavBar.isHidden = false
            scrolledCustomNavBar.isHidden = true
        }
    }
    
    
    
    
    // MARK: - Constraints
    private func setupConstraints() {        backgroundView1.translatesAutoresizingMaskIntoConstraints = false
        backgroundView2.translatesAutoresizingMaskIntoConstraints = false
        backgroundView3.translatesAutoresizingMaskIntoConstraints = false
        backgroundView4.translatesAutoresizingMaskIntoConstraints = false
        backgroundView5.translatesAutoresizingMaskIntoConstraints = false
        backgroundView6.translatesAutoresizingMaskIntoConstraints = false
        backgroundView7.translatesAutoresizingMaskIntoConstraints = false
        backgroundView8.translatesAutoresizingMaskIntoConstraints = false

        
        // Layout constraints
        NSLayoutConstraint.activate([
            backgroundView1.heightAnchor.constraint(equalToConstant: 450),
            backgroundView2.heightAnchor.constraint(equalToConstant: 450),
            backgroundView3.heightAnchor.constraint(equalToConstant: 600),
            backgroundView4.heightAnchor.constraint(equalToConstant: 400),
            backgroundView5.heightAnchor.constraint(equalToConstant: 400),
            backgroundView6.heightAnchor.constraint(equalToConstant: 700),
            backgroundView7.heightAnchor.constraint(equalToConstant: 600),
            backgroundView8.heightAnchor.constraint(equalToConstant: 600)
            
        ])
    }
    
    
    
    // MARK: - StackView 내용
    
    // SeparatorView를 생성하는 함수
    private func createSeparatorView() -> UIView {
        let separatorView = UIView()
        
        // Separator의 높이를 1로 설정
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Separator의 배경 색상 설정
        separatorView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        return separatorView
    }
    
    private lazy var puzzleBackgroundView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        view.backgroundColor = .clear
        
        view.addSubview(puzzleImage1)
        view.addSubview(puzzleImage2)
        view.addSubview(puzzleImage3)
        view.addSubview(puzzleImage4)
        view.addSubview(puzzleImage5)
        view.addSubview(puzzleImage6)
        view.addSubview(puzzleImage7)
        view.addSubview(puzzleImage8)
        view.addSubview(puzzleImage9)
        
        NSLayoutConstraint.activate([
            puzzleImage1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            puzzleImage1.topAnchor.constraint(equalTo: view.topAnchor),
            
            puzzleImage2.centerYAnchor.constraint(equalTo: puzzleImage1.centerYAnchor),
            puzzleImage2.leadingAnchor.constraint(equalTo: puzzleImage1.trailingAnchor, constant: -23.5),
            
            puzzleImage3.centerYAnchor.constraint(equalTo: puzzleImage1.centerYAnchor),
            puzzleImage3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            puzzleImage4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            puzzleImage4.topAnchor.constraint(equalTo: puzzleImage1.bottomAnchor, constant: -23),
            
            puzzleImage5.centerXAnchor.constraint(equalTo: puzzleImage2.centerXAnchor),
            puzzleImage5.centerYAnchor.constraint(equalTo: puzzleImage4.centerYAnchor),
            
            puzzleImage6.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            puzzleImage6.centerYAnchor.constraint(equalTo: puzzleImage4.centerYAnchor),
            
            puzzleImage7.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            puzzleImage7.centerYAnchor.constraint(equalTo: puzzleImage9.centerYAnchor),
            
            puzzleImage8.leadingAnchor.constraint(equalTo: puzzleImage7.trailingAnchor, constant: -23.5),
            puzzleImage8.centerYAnchor.constraint(equalTo: puzzleImage9.centerYAnchor),
            
            puzzleImage9.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            puzzleImage9.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    
    private lazy var puzzleImage1: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage1")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece1")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 114.78)
        ])
        
        return imageView
    }()
    
    private lazy var puzzleImage2: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage2")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece2")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 114.78)
        ])
        
        return imageView
    }()

    private lazy var puzzleImage3: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage3")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece3")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 114.78),
            imageView.heightAnchor.constraint(equalToConstant: 114.78)
        ])
        
        return imageView
    }()

    private lazy var puzzleImage4: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage4")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece4")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()
    
    private lazy var puzzleImage5: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage5")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece5")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()


    private lazy var puzzleImage6: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage6")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece6")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 114.78),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()


    private lazy var puzzleImage7: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage7")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece7")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()

    private lazy var puzzleImage8: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage8")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece8")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 139.57),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()
    
    private lazy var puzzleImage9: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage9")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece9")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 114.78),
            imageView.heightAnchor.constraint(equalToConstant: 139.57)
        ])
        
        return imageView
    }()




    
    
    
    private lazy var backgroundView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        let label = UILabel()
        label.text = "🇯🇵 도쿄, 일본"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(label)

        view.addSubview(puzzleBackgroundView)
        
        /*// 서브뷰 정의 및 추가
        let puzzleView = UIView()
        puzzleView.backgroundColor = .blue
        view.addSubview(puzzleView)*/
                
        // Auto Layout 제약 조건 설정
        label.translatesAutoresizingMaskIntoConstraints = false
        //puzzleView.translatesAutoresizingMaskIntoConstraints = false
        puzzleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            
            puzzleBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            puzzleBackgroundView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            puzzleBackgroundView.widthAnchor.constraint(equalToConstant: 348),
            puzzleBackgroundView.heightAnchor.constraint(equalToConstant: 348)
            
            /*puzzleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            puzzleView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            puzzleView.widthAnchor.constraint(equalToConstant: 348),
            puzzleView.heightAnchor.constraint(equalToConstant: 348)*/
        ])
        
        return view
    }()
    
    
    
    private lazy var backgroundView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 상단 이모지
        let topEmojiView = UIImageView()
        topEmojiView.image = UIImage(named: "hmmEmoji")
                
        // 제목
        let titleLabel = UILabel()
        titleLabel.text = "이땐 이랬어요 :)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
                
        // 구분선
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "Black3")
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                
        // 중간 이모지들
        let middleEmojisLabel = UILabel()
        middleEmojisLabel.text = "😴😔🗿😷"
        middleEmojisLabel.font = UIFont.systemFont(ofSize: 28)
        middleEmojisLabel.textAlignment = .center
                
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "공항에서 방금 내렸는데\n 사람이 너무 많아서 힘든 상태다... \n아!! 빨리 정신 차려야하는데~~"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
                
        
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 13:07"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")
                
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            topEmojiView,
            titleLabel,
            separatorView,
            middleEmojisLabel,
            descriptionLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
                
        // 오토레이아웃 제약 조건 설정
        topEmojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            topEmojiView.widthAnchor.constraint(equalToConstant: 87.82),
            topEmojiView.heightAnchor.constraint(equalToConstant: 87.5)
        ])
        
        return view
    }()
    
    
    
    private lazy var backgroundView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 상단 이모지
        let topEmojiView = UIImageView()
        topEmojiView.image = UIImage(named: "ootdEmoji")
                
        // 제목
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 OOTD !"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
                
        // 구분선
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "Black3")
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                
        // 이미지 뷰들
        let imageView1 = UIImageView()
        let imageView2 = UIImageView()
        imageView1.image = UIImage(named: "ootdImage1")
        imageView2.image = UIImage(named: "ootdImage2")
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit
                
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "오늘을 위해 새로 장만했어 ^~^"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
                
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 15:13"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")

                
        // 이미지 뷰들을 담을 스택 뷰
        let imagesStackView = UIStackView(arrangedSubviews: [imageView1, imageView2])
        imagesStackView.axis = .horizontal
        imagesStackView.spacing = 16
        imagesStackView.distribution = .fillEqually
        imagesStackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            topEmojiView,
            titleLabel,
            separatorView,
            imagesStackView,
            descriptionLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
                
        // 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    
            // 이미지 뷰 스택 뷰의 너비 설정
            imagesStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imagesStackView.heightAnchor.constraint(equalToConstant: 150), // 높이는 필요에 따라 조절
            
            topEmojiView.widthAnchor.constraint(equalToConstant: 85.82),
            topEmojiView.heightAnchor.constraint(equalToConstant: 84.5)
        ])

        
        return view
    }()

    
    private lazy var backgroundView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
                
        // 이미지 뷰들
        let videoView = UIImageView()
        videoView.image = UIImage(named: "puzzleImage3")
        videoView.contentMode = .scaleAspectFit
        videoView.widthAnchor.constraint(equalToConstant: 348).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: 162).isActive = true
        
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "길가다가 찍어본 스티커사진"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
        
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 15:48"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")
        
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            videoView,
            descriptionLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
        
        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        return view
    }()
    
    
    private lazy var backgroundView5: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        label.text = "이따가 돈키호테 들렸다가... 음... 지금 몹시 피곤모드\n그래도 힘내서 열심히 돌아다녀야지 ~~ 연우는 나와 다르게 체력이 넘쳐난다 어떻게 저럴 수 있지..ㅋㅋㅋㅋ"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(named: "Black1")
        
        
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 16:02"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")
        
        
        
        
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            label,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)

                
        // Auto Layout 제약 조건 설정

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
        
        return view
    }()


    
    
    private lazy var backgroundView6: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 상단 이모지
        let topEmojiView = UIImageView()
        topEmojiView.image = UIImage(named: "selfieEmoji")
                
        // 제목
        let titleLabel = UILabel()
        titleLabel.text = "제 셀카에요~!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
                
        // 구분선
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "Black3")
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // 폴라로이드 모양 뷰
        let selfieBackgroundView = UIView()
        selfieBackgroundView.backgroundColor = .white
        selfieBackgroundView.layer.borderColor = UIColor(named: "Black3")?.cgColor
        selfieBackgroundView.layer.borderWidth = 1
        selfieBackgroundView.layer.cornerRadius = 5
                
        // 이미지 뷰
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selfieImage")
        imageView.contentMode = .scaleAspectFit
        selfieBackgroundView.addSubview(imageView)
                
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "기차 안에서"
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
        selfieBackgroundView.addSubview(descriptionLabel)
                
                
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            topEmojiView,
            titleLabel,
            separatorView,
            selfieBackgroundView
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
                
        // 오토레이아웃 제약 조건 설정
        selfieBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            topEmojiView.widthAnchor.constraint(equalToConstant: 85.82),
            topEmojiView.heightAnchor.constraint(equalToConstant: 84.5),
            
            selfieBackgroundView.widthAnchor.constraint(equalToConstant: 294),
            selfieBackgroundView.heightAnchor.constraint(equalToConstant: 387),
            
            imageView.widthAnchor.constraint(equalToConstant: 278),
            imageView.heightAnchor.constraint(equalToConstant: 328),
            imageView.centerXAnchor.constraint(equalTo: selfieBackgroundView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: selfieBackgroundView.topAnchor, constant: 15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: selfieBackgroundView.leadingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: selfieBackgroundView.bottomAnchor, constant: -12)
        ])

        
        return view
    }()
    
    
    
    private lazy var backgroundView7: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 상단 이모지
        let topEmojiView = UIImageView()
        topEmojiView.image = UIImage(named: "videoEmoji")
                
        // 제목
        let titleLabel = UILabel()
        titleLabel.text = "여행의 순간을 영상으로!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
                
        // 구분선
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "Black3")
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                

        // 이미지 뷰
        let videoView = UIImageView()
        videoView.image = UIImage(named: "puzzleImage4")
        videoView.contentMode = .scaleAspectFit
        videoView.widthAnchor.constraint(equalToConstant: 348).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: 162).isActive = true
        
                
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "스키야키 보글보글...🤤"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
                
        
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 19:12"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")
                
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            topEmojiView,
            titleLabel,
            separatorView,
            videoView,
            descriptionLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
                
        // 오토레이아웃 제약 조건 설정
        topEmojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            topEmojiView.widthAnchor.constraint(equalToConstant: 87.82),
            topEmojiView.heightAnchor.constraint(equalToConstant: 87.5)
        ])
        
        return view
    }()
    
    
    private lazy var backgroundView8: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 상단 이모지
        let topEmojiView = UIImageView()
        topEmojiView.image = UIImage(named: "smellEmoji")
                
        // 제목
        let titleLabel = UILabel()
        titleLabel.text = "여행지의 냄새는..."
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
                
        // 구분선
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "Black3")
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                

                
        // 설명 텍스트
        let descriptionLabel = UILabel()
        descriptionLabel.text = "냄새라... 역시 여름이라 그런지 여름의 향기가 나요~~ 풀냄새...?ㅋㅋ\n\n덥지만 향긋한 이 느낌"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Black1")
        descriptionLabel.numberOfLines = 0
                
        
        // 날짜 레이블
        let dateLabel = UILabel()
        dateLabel.text = "24.08.12 13:07"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(named: "Main3")
                
        // 스택 뷰에 모든 요소 추가
        let stackView = UIStackView(arrangedSubviews: [
            topEmojiView,
            titleLabel,
            separatorView,
            descriptionLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // 뷰에 스택 뷰 추가
        view.addSubview(stackView)
                
        // 오토레이아웃 제약 조건 설정
        topEmojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            topEmojiView.widthAnchor.constraint(equalToConstant: 87.82),
            topEmojiView.heightAnchor.constraint(equalToConstant: 87.5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
            
            
        ])
        
        return view
    }()
    
    
    
    // MARK: - Puzzle view 설정
    func convertToBlackAndWhiteAndInvert(image: UIImage, threshold: CGFloat = 0.5) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGImageAlphaInfo.none.rawValue
        
        guard let context = CGContext(data: nil,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: width,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo) else {
            return nil
        }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let pixelBuffer = context.data else { return nil }
        
        let thresholdValue = UInt8(threshold * 255)
        
        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = y * width + x
                let pixel = pixelBuffer.load(fromByteOffset: pixelIndex, as: UInt8.self)
                // 새로운 픽셀 값을 반전시킴
                let newPixel: UInt8 = pixel > thresholdValue ? 0 : 255
                pixelBuffer.storeBytes(of: newPixel, toByteOffset: pixelIndex, as: UInt8.self)
            }
        }
        
        guard let outputCGImage = context.makeImage() else { return nil }
        return UIImage(cgImage: outputCGImage)
    }


    
    func cropImageToMatchMask(image: UIImage, maskSize: CGSize) -> UIImage? {
        let imageSize = image.size
        
        let imageAspectRatio = imageSize.width / imageSize.height
        let maskAspectRatio = maskSize.width / maskSize.height
        
        var cropRect: CGRect
        
        if imageAspectRatio > maskAspectRatio {
            // 이미지가 더 넓은 경우: 양 옆을 잘라냄
            let newWidth = imageSize.height * maskAspectRatio
            let xOffset = (imageSize.width - newWidth) / 2
            cropRect = CGRect(x: xOffset, y: 0, width: newWidth, height: imageSize.height)
        } else {
            // 이미지가 더 높은 경우: 위아래를 잘라냄
            let newHeight = imageSize.width / maskAspectRatio
            let yOffset = (imageSize.height - newHeight) / 2
            cropRect = CGRect(x: 0, y: yOffset, width: imageSize.width, height: newHeight)
        }
        
        guard let croppedCGImage = image.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: croppedCGImage)
    }

    func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage? {
        guard let croppedImage = cropImageToMatchMask(image: image, maskSize: maskImage.size) else {
            return nil
        }

        let imageReference = croppedImage.cgImage
        let maskReference = maskImage.cgImage
        
        guard let mask = CGImage(maskWidth: maskReference!.width,
                                 height: maskReference!.height,
                                 bitsPerComponent: maskReference!.bitsPerComponent,
                                 bitsPerPixel: maskReference!.bitsPerPixel,
                                 bytesPerRow: maskReference!.bytesPerRow,
                                 provider: maskReference!.dataProvider!,
                                 decode: nil,
                                 shouldInterpolate: false) else {
            return nil
        }

        guard let maskedReference = imageReference!.masking(mask) else {
            return nil
        }

        return UIImage(cgImage: maskedReference)
    }

    func createPuzzlePiece(image: UIImage, mask: UIImage) -> UIImageView {
        guard let blackMaskedImage = convertToBlackAndWhiteAndInvert(image: mask) else { return UIImageView() }
        guard let maskedImage = maskImage(image: image, withMask: blackMaskedImage) else { return UIImageView() }
        let imageView = UIImageView(image: maskedImage)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }



}
