//
//  PuzzleViewController.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/20/24.
//

import UIKit

class PuzzleViewController: UIViewController {

    private lazy var puzzlesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    
    
    // 여행기록 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "연우와 우정여행"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
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
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateStackView)
        
        return stackView
    }()
        
    
    
    // 정보 라벨
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        
        // AttributedString 설정
        let fullText = "총 42개의 여행 조각들을 모았어요!"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        
        // 특정 텍스트에 색상 적용
        let numOfPuzzles = (fullText as NSString).range(of: "42개의 여행 조각들")
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Main3") ?? UIColor.systemPink, range: numOfPuzzles)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .bold), range: numOfPuzzles)
        label.attributedText = attributedString
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Black5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var photoCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let countLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            
            // AttributedString 설정
            let fullText = "31개"
            let attributedString = NSMutableAttributedString(string: fullText)
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

            // 특정 텍스트에 색상 적용
            let number = (fullText as NSString).range(of: "31")
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: number)
            label.attributedText = attributedString
            return label
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "사진"
            label.textColor = UIColor(named: "Black3")
            label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return label
        }()
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(nameLabel)
        
        return stackView
    }()
    
    private lazy var videoCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let countLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            
            // AttributedString 설정
            let fullText = "4개"
            let attributedString = NSMutableAttributedString(string: fullText)
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

            // 특정 텍스트에 색상 적용
            let number = (fullText as NSString).range(of: "4")
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: number)
            label.attributedText = attributedString
            return label
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "영상"
            label.textColor = UIColor(named: "Black3")
            label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return label
        }()
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(nameLabel)
        
        return stackView
    }()
    
    private lazy var musicCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let countLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            
            // AttributedString 설정
            let fullText = "1개"
            let attributedString = NSMutableAttributedString(string: fullText)
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

            // 특정 텍스트에 색상 적용
            let number = (fullText as NSString).range(of: "1")
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: number)
            label.attributedText = attributedString
            return label
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "음악"
            label.textColor = UIColor(named: "Black3")
            label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return label
        }()
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(nameLabel)
        
        return stackView
    }()
    
    
    private lazy var memoCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let countLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            
            // AttributedString 설정
            let fullText = "6개"
            let attributedString = NSMutableAttributedString(string: fullText)
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

            // 특정 텍스트에 색상 적용
            let number = (fullText as NSString).range(of: "6")
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: number)
            label.attributedText = attributedString
            return label
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "메모"
            label.textColor = UIColor(named: "Black3")
            label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            return label
        }()
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(nameLabel)
        
        return stackView
    }()
    
    
    private lazy var numOfLogsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 47
        
        stackView.addArrangedSubview(photoCountStack)
        stackView.addArrangedSubview(videoCountStack)
        stackView.addArrangedSubview(musicCountStack)
        stackView.addArrangedSubview(memoCountStack)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var explainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20

        
        view.addSubview(infoLabel)
        view.addSubview(separatorView)
        view.addSubview(numOfLogsStack)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorView.widthAnchor.constraint(equalToConstant: 318),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            
            numOfLogsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numOfLogsStack.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10)
        ])
           
        
        return view
    }()
    
    
    private lazy var travelPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "🇯🇵 도쿄, 일본"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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




    
    
    
    // 하단 버튼
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행기 이어보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "Main")
        button.layer.cornerRadius = 5
        return button
    }()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        // 상단 퍼즐 아이콘 추가
        //setupPuzzleIcons()
        
        view.addSubview(puzzlesImageView)
        view.addSubview(titleStackView)
        view.addSubview(explainView)
        view.addSubview(travelPlaceLabel)
        view.addSubview(puzzleBackgroundView)
        //view.addSubview(puzzleImage)
        view.addSubview(continueButton)
        
        
        setUpConstraints()
        // 하단 버튼 추가
        //setupContinueButton()
    }
    
    
    func setUpConstraints() {
        puzzlesImageView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        explainView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        puzzleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            puzzlesImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            puzzlesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            puzzlesImageView.widthAnchor.constraint(equalToConstant: 105.75),
            puzzlesImageView.heightAnchor.constraint(equalToConstant: 25.5),
            
            titleStackView.topAnchor.constraint(equalTo: puzzlesImageView.bottomAnchor, constant: 30),
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            explainView.widthAnchor.constraint(equalToConstant: 348),
            explainView.heightAnchor.constraint(equalToConstant: 106),
            explainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            explainView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20),
            
            travelPlaceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            travelPlaceLabel.topAnchor.constraint(equalTo: explainView.bottomAnchor, constant: 26),
            
            puzzleBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            puzzleBackgroundView.topAnchor.constraint(equalTo: travelPlaceLabel.bottomAnchor, constant: 15),
            puzzleBackgroundView.widthAnchor.constraint(equalToConstant: 348),
            puzzleBackgroundView.heightAnchor.constraint(equalToConstant: 348),
            
                        
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 348),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
        
        



    
    func setupContinueButton() {
        view.addSubview(continueButton)
        
        
    }
    
    
    
    
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

