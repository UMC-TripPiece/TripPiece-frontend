//
//  PuzzleLastViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/23/24.
//

import UIKit
import SnapKit

class FinishPuzzleViewController: UIViewController {
    
    var travelId: Int

    init(travelId: Int) {
        self.travelId = travelId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var customNavBar: FinishNavigationBar = {
        let nav = FinishNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
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
            return imageView
        }()
        dateImageView.snp.makeConstraints{ make in
            make.width.height.equalTo(18)
        }
        
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
    
    //MARK: - 여행조각들
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
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Black5")
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
            let fullText = "0개"
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
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.width.equalTo(318)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom).offset(12)
        }
        
        numOfLogsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(separatorView.snp.bottom).offset(10)
        }
        return view
    }()
    
    //MARK: - 도시, 나라
    private lazy var travelPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "🇯🇵 도쿄, 일본"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - 퍼즐뷰
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
        
        puzzleImage1.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
            
        puzzleImage2.snp.makeConstraints { make in
            make.centerY.equalTo(puzzleImage1.snp.centerY)
            make.leading.equalTo(puzzleImage1.snp.trailing).offset(-23.5)
        }
            
        puzzleImage3.snp.makeConstraints { make in
            make.centerY.equalTo(puzzleImage1.snp.centerY)
            make.trailing.equalToSuperview()
        }
            
        puzzleImage4.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(puzzleImage1.snp.bottom).offset(-23)
        }
            
        puzzleImage5.snp.makeConstraints { make in
            make.centerX.equalTo(puzzleImage2.snp.centerX)
            make.centerY.equalTo(puzzleImage4.snp.centerY)
        }
            
        puzzleImage6.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(puzzleImage4.snp.centerY)
        }
            
        puzzleImage7.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(puzzleImage9.snp.centerY)
        }
            
        puzzleImage8.snp.makeConstraints { make in
            make.leading.equalTo(puzzleImage7.snp.trailing).offset(-23.5)
            make.centerY.equalTo(puzzleImage9.snp.centerY)
        }
            
        puzzleImage9.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return view
    }()
    
    private lazy var puzzleImage1: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage1")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece1")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(114.78)
        }
        
        return imageView
    }()
    
    private lazy var puzzleImage2: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage2")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece2")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(114.78)
        }
        
        return imageView
    }()

    private lazy var puzzleImage3: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage3")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece3")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(114.78)
            make.height.equalTo(114.78)
        }
        
        return imageView
    }()

    private lazy var puzzleImage4: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage4")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece4")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()
    
    private lazy var puzzleImage5: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage5")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece5")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()


    private lazy var puzzleImage6: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage6")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece6")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(114.78)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()


    private lazy var puzzleImage7: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage7")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece7")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()

    private lazy var puzzleImage8: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage8")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece8")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(139.57)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()
    
    private lazy var puzzleImage9: UIImageView = {
        // 예시로 사용될 메인 이미지와 퍼즐 조각 마스크 이미지
        let mainImage = UIImage(named: "puzzleImage9")! // 전체 이미지
        let puzzleMaskImage = UIImage(named: "puzzlePiece9")! // 퍼즐 조각 마스크 이미지

        // 퍼즐 조각 이미지 뷰 생성
        let imageView = createPuzzlePiece(image: mainImage, mask: puzzleMaskImage)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(114.78)
            make.height.equalTo(139.57)
        }
        
        return imageView
    }()
    
    //MARK: - 버튼
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행기 이어보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "Main")
        button.layer.cornerRadius = 5
        return button
    }()

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()
        fetchTravelData(travelId: travelId)

    }

    
    @objc private func handleTravelLogStarted() {
        // Dismiss the current view controller, navigating back
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(titleStackView)
        view.addSubview(explainView)
        view.addSubview(travelPlaceLabel)
        view.addSubview(puzzleBackgroundView)
        view.addSubview(continueButton)
        setConstraints()
    }
    func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        titleStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(customNavBar.snp.bottom).offset(30)
        }
        explainView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalTo(titleStackView.snp.bottom).offset(20)
            make.height.equalTo(106)
        }
        travelPlaceLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(explainView.snp.bottom).offset(26)
        }
        puzzleBackgroundView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(travelPlaceLabel.snp.bottom).offset(15)
            make.width.height.equalTo(348)
        }
        continueButton.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
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
    //MARK: - GET
    func fetchTravelData(travelId: Int) {
        guard let url = URL(string: "http://3.34.111.233:8080/travels/\(travelId)") else { return }

        // URLRequest 객체를 만듭니다.
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // HTTP 메서드는 GET

        // URLSession을 사용하여 데이터를 요청합니다.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }

            // 서버로부터 받은 데이터를 문자열로 변환하여 출력합니다.
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                
                do {
                    // JSON 응답을 디코딩합니다.
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let isSuccess = json?["isSuccess"] as? Bool, isSuccess,
                       let result = json?["result"] as? [String: Any],
                       let title = result["title"] as? String,
                       let city = result["city"] as? String,
                       let country = result["country"] as? String,
                       let countryImage = result["countryImage"] as? String,
                       let startDate = result["startDate"] as? String,
                       let endDate = result["endDate"] as? String,
                       let totalPieces = result["totalPieces"] as? Int,
                       let memoCount = result["memoCount"] as? Int,
                       let pictureCount = result["pictureCount"] as? Int,
                       let videoCount = result["videoCount"] as? Int,
                       let pictureSummaries = result["pictureSummaries"] as? [[String: Any]] {

                        DispatchQueue.main.async {
                            //UI 업데이트
                            self.titleLabel.text = "\(title)"
                            self.travelPlaceLabel.text = "\(countryImage) \(city), \(country)"
                            if let dateLabel = self.dateStackView.arrangedSubviews[1] as? UILabel {
                                dateLabel.text = "\(startDate)~\(endDate)"
                            }
                            
                            // 퍼즐 데이터 업데이트
                            let fullText = "총 \(totalPieces)개의 여행 조각들을 모았어요!"
                            let attributedString = NSMutableAttributedString(string: fullText)

                            // "totalPieces" 부분의 범위를 찾습니다.
                            if let rangeOfTotalPieces = fullText.range(of: "\(totalPieces)개의 여행 조각들") {
                                // NSString으로 변환하여 NSRange를 가져옵니다.
                                let nsRange = NSRange(rangeOfTotalPieces, in: fullText)
                                attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Main3") ?? UIColor.systemPink, range: nsRange)
                            }
                            self.infoLabel.attributedText = attributedString
                            
                            if let countLabel = self.memoCountStack.arrangedSubviews.first as? UILabel {
                                let fullText = "\(memoCount)개"
                                
                                let attributedString = NSMutableAttributedString(string: fullText)
                                let numberRange = (fullText as NSString).range(of: "\(memoCount)")
                                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: numberRange)
                                
                                countLabel.attributedText = attributedString
                            }
                            
                            if let countLabel = self.photoCountStack.arrangedSubviews.first as? UILabel {
                                let fullText = "\(pictureCount)개"
                                
                                let attributedString = NSMutableAttributedString(string: fullText)
                                let numberRange = (fullText as NSString).range(of: "\(pictureCount)")
                                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: numberRange)
                                
                                countLabel.attributedText = attributedString
                            }
                            
                            if let countLabel = self.videoCountStack.arrangedSubviews.first as? UILabel {
                                let fullText = "\(videoCount)개"
                                
                                let attributedString = NSMutableAttributedString(string: fullText)
                                let numberRange = (fullText as NSString).range(of: "\(videoCount)")
                                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: numberRange)
                                
                                countLabel.attributedText = attributedString
                            }
                            
                            // pictureSummaries
                            if let pictureSummaries = result["pictureSummaries"] as? [[String: Any]] {
                                // 각 퍼즐 이미지에 순서대로 할당
                                let puzzleImages = [self.puzzleImage1, self.puzzleImage2, self.puzzleImage3, self.puzzleImage4, self.puzzleImage5, self.puzzleImage6, self.puzzleImage7, self.puzzleImage8, self.puzzleImage9]
                                
                                for (index, pictureSummary) in pictureSummaries.prefix(puzzleImages.count).enumerated() {
                                    if let mediaUrls = pictureSummary["mediaUrls"] as? [String], let firstMediaUrl = mediaUrls.first, let url = URL(string: firstMediaUrl) {
                                        // Download image using SDWebImage
                                        puzzleImages[index].sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { [weak self] (image, error, cacheType, imageURL) in
                                            guard let self = self else { return }
                                            if let downloadedImage = image {
                                                // Replace the main image with the downloaded image
                                                let puzzleMaskImage = UIImage(named: "puzzlePiece\(index + 1)")!
                                                let imageView = self.createPuzzlePiece(image: downloadedImage, mask: puzzleMaskImage)
                                                
                                                // Replace the existing imageView with the new one containing the downloaded image
                                                puzzleImages[index].image = imageView.image
                                            }
                                        })
                                    }
                                }
                            }

                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

}
