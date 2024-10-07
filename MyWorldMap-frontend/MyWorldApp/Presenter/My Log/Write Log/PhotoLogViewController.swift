//
//  PhotoLogViewController.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/2/24.
//

import UIKit
import SnapKit
import Alamofire

class PhotoLogViewController: UIViewController {

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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 추가"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진을 추가한 후 \n설명을 작성해보세요!"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "subtitle")
        return label
    }()

    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dum1")
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
        return stackView
    }()

    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var photoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 4장 첨부 가능합니다"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Black2")
        return label
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
        textView.textColor = UIColor(named: "Black3")
        textView.text = "| 사진에 대해 설명해주세요! (100자 이내)"
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.cornerRadius = 5
        textView.delegate = self
        return textView
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

    private var selectedImages: [UIImage] = [] {
        didSet {
            updateAddButtonState()
        }
    }

    //MARK: - Init
    override func viewDidLoad() {
        setupDismissKeyboardGesture()
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customNavBar)
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(handleBackButtonTap), name: .backButtonTapped, object: nil)
    }

    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleImageView)
        view.addSubview(photosStackView)
        view.addSubview(addButton)

        view.addSubview(grayBackgroundView)
        grayBackgroundView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(photosStackView)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        contentStackView.addArrangedSubview(photoSubtitleLabel)
        contentStackView.addArrangedSubview(createSpacer(height: 30))
        contentStackView.addArrangedSubview(memoTitleLabel)
        contentStackView.addArrangedSubview(createSpacer(height: 10))
        contentStackView.addArrangedSubview(memoTextView)
        contentStackView.addArrangedSubview(createSpacer(height: 132))
        contentStackView.addArrangedSubview(addButton)

        setConstraints()
        setupPhotosStackView()
    }

    private func createSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }

    func setConstraints() {
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(grayBackgroundView.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(21)
        }

        memoTextView.snp.makeConstraints { make in
            make.height.equalTo(154)
        }

        addButton.snp.makeConstraints { make in
            make.height.equalTo(50) // 원하는 버튼 높이
        }
    }

    //MARK: - Function
    private func setupPhotosStackView() {
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "add photo")
            imageView.tintColor = .gray
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.2
            imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageView.isUserInteractionEnabled = true

            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(80) // 크기를 80x80으로 설정
            }

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
            imageView.addGestureRecognizer(tapGesture)
            photosStackView.addArrangedSubview(imageView)
        }
    }

    private func updateAddButtonState() {
        let isMemoValid = !memoTextView.text.isEmpty && memoTextView.text != "| 사진에 대해 설명해주세요! (100자 이내)"
        addButton.isEnabled = !selectedImages.isEmpty && isMemoValid
        addButton.backgroundColor = (selectedImages.isEmpty || !isMemoValid) ? UIColor(named: "Cancel") : UIColor(named: "Main")
    }

    ///뒤로가기 버튼
    @objc private func handleBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }

    ///사진 추가 버튼 클릭
    @objc private func selectPhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "카메라 열기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "카메라 사용 불가", message: "카메라를 사용할 수 없습니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let libraryAction = UIAlertAction(title: "라이브러리에서 사진 선택", style: .default) { _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    @objc private func addRecord() {
        postPhotoLog()
    }

    //MARK: - POST 요청
    private func postPhotoLog() {
        guard let url = URL(string: "http://3.34.111.233:8080/mytravels/\(travelId)/picture") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        if let refreshToken = getRefreshToken() {
            request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        }
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        // memo 부분
        let memoDescription = [
            "description": memoTextView.text ?? ""
        ]
        
        if let memoData = try? JSONSerialization.data(withJSONObject: memoDescription, options: []) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"memo\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(memoData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // photos 부분, 압축률을 0.5로 낮춤
        for (index, image) in selectedImages.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photos\"; filename=\"photo\(index).jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            } else {
                print("Failed to decode response.")
            }
            
            DispatchQueue.main.async {
                self.navigateToPhotoCompleteViewController()
            }
        }
        task.resume()
    }

    private func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    var videoImage: UIImage?
    private func navigateToPhotoCompleteViewController() {
        let recordCompleteVC = PhotoCompleteViewController()
        recordCompleteVC.images = selectedImages
        recordCompleteVC.memoText = memoTextView.text
        recordCompleteVC.modalPresentationStyle = .fullScreen
        present(recordCompleteVC, animated: true, completion: nil)
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Extension
extension PhotoLogViewController: UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "| 사진에 대해 설명해주세요! (100자 이내)" {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "| 사진에 대해 설명해주세요! (100자 이내)"
            textView.textColor = UIColor(named: "Black3")
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 100 // 글자 수 제한 100자
    }

    func textViewDidChange(_ textView: UITextView) {
        updateAddButtonState()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            if selectedImages.count < 4 {
                selectedImages.append(selectedImage)
                let imageView = photosStackView.arrangedSubviews[selectedImages.count - 1] as! UIImageView
                imageView.image = selectedImage
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
