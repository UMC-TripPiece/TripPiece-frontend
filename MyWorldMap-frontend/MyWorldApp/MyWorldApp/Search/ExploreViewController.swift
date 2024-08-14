import UIKit
import SnapKit

class ExploreViewController: UIViewController {

    // UI 요소 선언
    let topBar = UIView()
    let puzzle = UIImageView(image: UIImage(named: "puzzle"))
    let exploreLabel = UILabel()
    let friendListButton = UIButton()
    let searchField = UITextField()
    let trendingCitiesLabel = UILabel()
    let trendingCitiesSubtitle = UILabel()
    let trendingCitiesScrollView = UIScrollView()
    let trendingCitiesStackView = UIStackView()
    let dividingLine = UIView()
    let tokyoLabel = UILabel()
    let tokyoSubtitle = UILabel()
    let tokyoScrollView = UIScrollView()
    let tokyoStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 설정 및 초기화
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(hex: "F7F7F7")
        
        topBar.backgroundColor = .white
        
        // 상단 바 설정
        exploreLabel.text = "탐색"
        exploreLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        exploreLabel.textColor = UIColor(hex: "6644FF")
        
        friendListButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        friendListButton.tintColor = UIColor(hex:"696969")
        friendListButton.setTitle(" 친구 목록", for: .normal)
        friendListButton.setTitleColor(UIColor(hex:"696969"), for: .normal)
        friendListButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        searchField.placeholder = " | 도시 및 국가를 검색해보세요"
        searchField.borderStyle = .roundedRect
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor(hex: "6644FF").cgColor
        searchField.layer.cornerRadius = 8
        searchField.rightViewMode = .always
        let magnifyingGlassImageView = UIImageView(image: UIImage(named: "magnifyingGlass"))
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        magnifyingGlassImageView.frame = CGRect(x: -5, y: 5, width: 20, height: 20)
        paddingView.addSubview(magnifyingGlassImageView)
        searchField.rightView = paddingView
        
        trendingCitiesLabel.text = "요즘 떠오르는 도시"
        trendingCitiesLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        trendingCitiesLabel.textColor = UIColor(hex: "3A3A3A")
        
        trendingCitiesSubtitle.text = "여행 조각들이 많이 기록되는 도시들이에요"
        trendingCitiesSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        trendingCitiesSubtitle.textColor = UIColor(hex: "777777")
        
        // 스크롤뷰 & 스택뷰 설정
        trendingCitiesScrollView.showsHorizontalScrollIndicator = false
        trendingCitiesStackView.axis = .horizontal
        trendingCitiesStackView.spacing = 10
        
        dividingLine.backgroundColor = UIColor(hex: "F2F2F2")
        
        tokyoLabel.text = "도쿄 여행 조각"
        tokyoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tokyoLabel.textColor = UIColor(hex: "3A3A3A")
        
        tokyoSubtitle.text = "도쿄에 있는 사용자들이 기록한 조각들이에요"
        tokyoSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        tokyoSubtitle.textColor = UIColor(hex: "777777")
        
        tokyoScrollView.showsHorizontalScrollIndicator = false
        tokyoStackView.axis = .horizontal
        tokyoStackView.spacing = 10
        
        // 서브뷰 추가
        view.addSubview(topBar)
        topBar.addSubview(puzzle)
        topBar.addSubview(exploreLabel)
        topBar.addSubview(friendListButton)
        view.addSubview(searchField)
        view.addSubview(trendingCitiesLabel)
        view.addSubview(trendingCitiesSubtitle)
        view.addSubview(trendingCitiesScrollView)
        trendingCitiesScrollView.addSubview(trendingCitiesStackView)
        view.addSubview(dividingLine)
        view.addSubview(tokyoLabel)
        view.addSubview(tokyoSubtitle)
        view.addSubview(tokyoScrollView)
        tokyoScrollView.addSubview(tokyoStackView)
        
        // 예시 도시 이미지 추가
        addTrendingCityCard(to: trendingCitiesStackView, imageName: "city1", title: "후쿠오카, 일본", subtitle: "1,084명이 여행했어요", isFirstCard: true)
        addTrendingCityCard(to: trendingCitiesStackView, imageName: "city2", title: "런던, 영국", subtitle: "987명이 여행했어요", isFirstCard: false)
        addTrendingCityCard(to: trendingCitiesStackView, imageName: "city3", title: "뉴욕, 미국", subtitle: "602명이 여행했어요", isFirstCard: false)
        addTrendingCityCard(to: trendingCitiesStackView, imageName: "city4", title: "다낭, 베트남", subtitle: "482명이 여행했어요", isFirstCard: false)
        
        // 예시 도쿄 여행 조각 추가
        
        addCityCard(to: tokyoStackView, imageName: "city5", title: "작은 고양이", isFirstCard: true, profileImageName: "profileExample1")
        addCityCard(to: tokyoStackView, imageName: "city6", title: "김여행", isFirstCard: false, profileImageName: "profileExample2")
        addCityCard(to: tokyoStackView, imageName: "city7", title: "시끄러운 쿼카",  isFirstCard: false, profileImageName: "profileExample3")
        addCityCard(to: tokyoStackView, imageName: "city8", title: "고독한 미식가", isFirstCard: false, profileImageName: "profileExample4")
    }
    
    func setupConstraints() {
        topBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(100) // Adjust the height as needed
        }
        puzzle.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
            make.height.width.equalTo(20)
        }
        exploreLabel.snp.makeConstraints { make in
            make.left.equalTo(puzzle.snp.right).offset(8)
            make.centerY.equalTo(puzzle.snp.centerY)
        }
        
        friendListButton.snp.makeConstraints { make in
            make.centerY.equalTo(exploreLabel)
            make.right.equalToSuperview().offset(-16)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        trendingCitiesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        trendingCitiesSubtitle.snp.makeConstraints { make in
            make.top.equalTo(trendingCitiesLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        trendingCitiesScrollView.snp.makeConstraints { make in
            make.top.equalTo(trendingCitiesSubtitle.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        trendingCitiesStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview()
        }
        
        dividingLine.snp.makeConstraints { make in
            make.top.equalTo(trendingCitiesScrollView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(5) // Adjust the height as needed
        }
        
        tokyoLabel.snp.makeConstraints { make in
            make.top.equalTo(dividingLine.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
        }
        
        tokyoSubtitle.snp.makeConstraints { make in
            make.top.equalTo(tokyoLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        tokyoScrollView.snp.makeConstraints { make in
            make.top.equalTo(tokyoSubtitle.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        tokyoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview()
        }
    }

    func addTrendingCityCard(to stackView: UIStackView, imageName: String, title: String, subtitle: String, isFirstCard: Bool) {
        let cityView = UIView()
        cityView.backgroundColor = .black
        cityView.layer.cornerRadius = 10
        cityView.clipsToBounds = true
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.7
        cityView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .white
        cityView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-28)
            make.left.equalToSuperview().offset(8)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        subtitleLabel.textColor = UIColor(hex: "EAEAEA")
        cityView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(8)
        }
        
        stackView.addArrangedSubview(cityView)
        cityView.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(stackView.snp.height)
        }
        
        // Adjust the spacing to provide the left inset for the first card
        if isFirstCard {
            cityView.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
            }
        }
    }
    
    func addCityCard(to stackView: UIStackView, imageName: String, title: String, isFirstCard: Bool, profileImageName: String?) {
        let cityView = UIView()
        cityView.backgroundColor = .black
        cityView.layer.cornerRadius = 10
        cityView.clipsToBounds = true
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.7
        cityView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Add a white bottom bar
        let bottomBar = UIView()
        bottomBar.backgroundColor = .white
        cityView.addSubview(bottomBar)
        bottomBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40) // Adjust the height as needed
        }
        
        // Add the profile image view
        if let profileImageName = profileImageName {
            let profileImageView = UIImageView(image: UIImage(named: profileImageName))
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 10 // Assuming a 40x40 size
            profileImageView.clipsToBounds = true
            bottomBar.addSubview(profileImageView)
            profileImageView.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.left.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
            }
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            titleLabel.textColor = .black
            bottomBar.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in make.left.equalTo(profileImageView.snp.right).offset(8)
                make.centerY.equalTo(profileImageView.snp.centerY)// Adjust if profile image exists
            }

        }
        
        stackView.addArrangedSubview(cityView)
        cityView.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.height.equalTo(stackView.snp.height)
        }
        
        // Adjust the spacing to provide the left inset for the first card
        if isFirstCard {
            cityView.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
            }
        }
    }
}
