//
//  VisitRecordCell.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/18/24.
//

import UIKit

class VisitRecordCell: UITableViewCell {
    
    static let identifier = "VisitRecordCell"
    
    var buttonAction: (([String: String]) -> Void)?

    var cityData: [String: String]? // 전달할 데이터
    
    private let puzzleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        //imageView.image = UIImage(named: "Puzzle1")
        return imageView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let editCountryLogButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "editButton"), for: .normal)  // 버튼 모양을 이미지로 설정
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    
    
    var editOptionsView: EditOptionsView?
    
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        // 그림자 설정
        view.layer.shadowColor = UIColor.black.cgColor  // 그림자 색상
        view.layer.shadowOpacity = 0.1                 // 그림자 불투명도 (0.0 - 1.0)
        view.layer.shadowOffset = CGSize(width: 0, height: 0) // 그림자 오프셋 (x, y)
        view.layer.shadowRadius = 5                     // 그림자 블러 반경
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        // 컨테이너 뷰 설정
        
        contentView.addSubview(containerView)
        contentView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // 국기 이미지 뷰 설정
        containerView.addSubview(puzzleImageView)
        containerView.addSubview(countryLabel)
        containerView.addSubview(editCountryLogButton)
        editCountryLogButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)

        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -30),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            
            // 컨테이너 뷰 설정
            containerView.heightAnchor.constraint(equalToConstant: 68),
            containerView.widthAnchor.constraint(equalToConstant: 348),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // 국기 이미지 뷰 설정
            puzzleImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            puzzleImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            puzzleImageView.widthAnchor.constraint(equalToConstant: 35.75),
            puzzleImageView.heightAnchor.constraint(equalToConstant: 35.75),
            
            // 국가 이름 라벨 설정
            countryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            countryLabel.leftAnchor.constraint(equalTo: puzzleImageView.rightAnchor, constant: 16.25),
            //countryLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12),
            
            // 수정 버튼 설정
            editCountryLogButton.widthAnchor.constraint(equalToConstant: 14),
            editCountryLogButton.heightAnchor.constraint(equalToConstant: 14),
            editCountryLogButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            editCountryLogButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    func configure(countryName: String, flagEmoji: String, puzzleColor: String) {
        setupCell()
        countryLabel.text = "\(flagEmoji) \(countryName)"
        // 퍼즐 컬러에 따라 이미지를 다르게 설정
        switch puzzleColor {
        case "BLUE":
            puzzleImageView.image = UIImage(named: "Puzzle1")
        case "YELLOW":
            puzzleImageView.image = UIImage(named: "Puzzle2")
        case "CYAN":
            puzzleImageView.image = UIImage(named: "Puzzle3")
        case "RED":
            puzzleImageView.image = UIImage(named: "Puzzle4")
        default:
            puzzleImageView.image = nil // 기본값으로 이미지를 제거하거나 원하는 다른 이미지를 설정
            }
        
    }
    
    
    
    @objc private func showOptions() {
            guard let superview = self.superview else { return }
            
            // 메뉴 뷰 생성 및 추가
            if let editOptionsView = editOptionsView {
                editOptionsView.removeFromSuperview() // 기존 메뉴 제거
                self.editOptionsView = nil
                return
            }
            
            let editOptionsView = EditOptionsView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
            self.editOptionsView = editOptionsView
            editOptionsView.translatesAutoresizingMaskIntoConstraints = false
            superview.addSubview(editOptionsView)

            NSLayoutConstraint.activate([
                editOptionsView.trailingAnchor.constraint(equalTo: editCountryLogButton.trailingAnchor),
                editOptionsView.topAnchor.constraint(equalTo: editCountryLogButton.bottomAnchor, constant: 8),
                editOptionsView.widthAnchor.constraint(equalToConstant: 115),
                editOptionsView.heightAnchor.constraint(equalToConstant: 73)
            ])

            // 메뉴 버튼 액션 설정
            editOptionsView.editButton.addTarget(self, action: #selector(editLogAction), for: .touchUpInside)
            editOptionsView.deleteButton.addTarget(self, action: #selector(deleteLogAction), for: .touchUpInside)
        }
    
    
    
    @objc private func editLogAction() {
            // 수정하기 액션 처리
 
        if let cityData = cityData {
            buttonAction?(cityData)
        }
    }

        @objc private func deleteLogAction() {
            // 삭제하기 액션 처리
            print("기록 삭제 선택됨")
        }
}




// 기록 수정 버튼 custom
class EditOptionsView: UIView {

    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setImage(UIImage(named: "editPencil"), for: .normal)  // 펜슬 아이콘
        button.tintColor = UIColor(named: "Black2")
        button.setTitleColor(UIColor(named: "Black2"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // 제약 조건 설정
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.imageView!.widthAnchor.constraint(equalToConstant: 28),
            button.imageView!.heightAnchor.constraint(equalToConstant: 28),
            button.imageView!.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 2),
            button.imageView!.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 5)
        ])
        
        
        return button
    }()

    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("기록 삭제", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setImage(UIImage(named: "deleteBin"), for: .normal)  // 휴지통 아이콘
        button.tintColor = UIColor(named: "Main3")
        button.setTitleColor(UIColor(named: "Main3"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        
        // 제약 조건 설정
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.imageView!.widthAnchor.constraint(equalToConstant: 24),
            button.imageView!.heightAnchor.constraint(equalToConstant: 24),
            button.imageView!.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -2),
            button.imageView!.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 5)
        ])
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5

        addSubview(editButton)
        addSubview(deleteButton)

        // Auto Layout 설정
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor),
            editButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 36.5),

            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
