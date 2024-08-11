//
//  LoginView.swift
//  MyWorldApp
//
//  Created by 이예성 on 7/29/24.
//


import UIKit

class loginView: UIView {
    //MARK: - UI ProPerties
    //로고
    lazy var logo:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "AppIcon")
        
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "backgroundImage")
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            return view
        }()
    
    //MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func SetView() {
        addSubview(backgroundImage)
        addSubview(logo)
//        self.backgroundColor = .white
    }
    
    
    func setConstraints() {
            let superviewHeight = UIScreen.main.bounds.height
            
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
                        make.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
                        make.leading.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.1)
                        make.trailing.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
                }
            
            logo.snp.makeConstraints { make in
                make.size.equalTo(140)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(superviewHeight * 0.3)
            }
        }
    
    
    }
    


