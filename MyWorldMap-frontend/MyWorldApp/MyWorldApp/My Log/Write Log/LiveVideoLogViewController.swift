import UIKit
import SnapKit
import AVKit
import UniformTypeIdentifiers

class LiveVideoLogViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var travelId: Int
            
        init(travelId: Int) {
            self.travelId = travelId
            super.init(nibName: nil, bundle: nil)
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK: - UI
    private lazy var customNavBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 어디에 있나요?"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "영상으로 지금 이 순간을 \n카메라에 담아보세요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "subtitle")
        return label
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dum2")
        return imageView
    }()
    
    private lazy var grayBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BgColor2")
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var videoPreviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVideo))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = " | 영상에 대해 설명해주세요 (30자 이내)"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록 추가", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.addTarget(self, action: #selector(addRecord), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        setupDismissKeyboardGesture()
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()
        
        // NotificationCenter 관찰자 추가
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleImageView)
        
        view.addSubview(addButton)
        view.addSubview(grayBackgroundView)
        
        grayBackgroundView.addSubview(videoPreviewView)
        grayBackgroundView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(memoTitleLabel)
        contentStackView.addArrangedSubview(memoTextView)
        memoTextView.addSubview(placeholderLabel)
        contentStackView.addArrangedSubview(addButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(customNavBar.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(21)
        }
        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(customNavBar.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(21)
            make.height.greaterThanOrEqualTo(42)
        }
        titleImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(129)
            make.trailing.equalToSuperview().inset(21.18)
        }
        
        grayBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(grayBackgroundView.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        videoPreviewView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        memoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(videoPreviewView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(21)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.height.equalTo(69)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.leading.equalToSuperview().offset(5)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Function
    
    @objc private func handleBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addRecord() {
        // 기록 추가 기능 구현
    }
    
//    @objc private func selectVideo() {
//        let alert = UIAlertController(title: "동영상 추가", message: "", preferredStyle: .actionSheet)
//        
//        alert.addAction(UIAlertAction(title: "카메라로 촬영", style: .default, handler: { _ in
//            self.presentVideoPicker()
//        }))
//        
//        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    @objc private func selectVideo() {
        let alert = UIAlertController(title: "동영상 추가", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "라이브러리에서 동영상 선택", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    ///앨범 열기
    private func openPhotoLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.movie"]
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc private func presentVideoPicker() {
        let videoPicker = UIImagePickerController()
        videoPicker.delegate = self
        videoPicker.sourceType = .camera
        videoPicker.mediaTypes = [UTType.movie.identifier]
        videoPicker.allowsEditing = true
        present(videoPicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[.mediaURL] as? URL {
            // 비디오 URL 로그로 출력
            print("Selected video URL: \(videoURL.absoluteString)")

            // 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: videoURL.path) {
                print("Video file exists at path: \(videoURL.path)")
                playVideoPreview(videoURL)
            } else {
                print("Video file does not exist at path: \(videoURL.path)")
            }
        } else {
            print("Failed to retrieve video URL.")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func playVideoPreview(_ url: URL) {
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        
        // 비디오 미리보기를 videoPreviewView에 맞게 표시, 비율 유지
        playerLayer.frame = videoPreviewView.bounds
        playerLayer.videoGravity = .resizeAspect // Aspect Fit으로 변경
        
        // 기존 레이어 제거 후 새로운 레이어 추가
        videoPreviewView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        videoPreviewView.layer.addSublayer(playerLayer)
        
        // 비디오 프리뷰 뷰를 최상위로 이동
        videoPreviewView.bringSubviewToFront(videoPreviewView)
        
        player.play()
        
        // "기록 추가" 버튼 활성화
        addButton.isEnabled = true
        addButton.backgroundColor = UIColor(hex: "6644FF")
    }
    
//    private func playVideoPreview(_ url: URL) {
//        let player = AVPlayer(url: url)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = videoPreviewView.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//        videoPreviewView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//        videoPreviewView.layer.addSublayer(playerLayer)
//        player.play()
//        
//        // "기록 추가" 버튼 활성화
//        addButton.isEnabled = true
//        addButton.backgroundColor = UIColor(hex: "6644FF")
//        
//        buttonsStackView.isHidden = true
//    }
}

extension LiveVideoLogViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 텍스트뷰에 텍스트가 있으면 placeholder 숨김, 없으면 표시
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

