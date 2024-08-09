//
//  TabBar.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        appearance()
    }
<<<<<<< Updated upstream
    private func setTabBar(){
        let vc1 = UINavigationController(rootViewController: WorldViewController())
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "globe.central.south.asia.fill"), tag: 1)
        let vc2 = MyLogViewController()
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book.closed.fill"), tag: 2)
        let vc3 = SearchViewController()
        vc3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "safari.fill"), tag: 3)
        let vc4 = MyPageViewController()
        vc4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"), tag: 3)
        self.viewControllers = [vc1,vc2,vc3,vc4]
=======

    private func setTabBar() {
        //TODO - 여기서 월드 부분 뭐시기 컨트롤러? 뭐 그런걸로 해야 스유랑 연결됨
        let vc1 = UINavigationController(rootViewController: WorldViewController())
        vc1.tabBarItem = UITabBarItem(title: "월드", image: UIImage(named: "World"), tag: 1)
        let vc2 = UINavigationController(rootViewController: LogViewController())
        vc2.tabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: "My log"), tag: 2)
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        vc3.tabBarItem = UITabBarItem(title: "탐색", image: UIImage(named: "Search"), tag: 3)
        let vc4 = UINavigationController(rootViewController: MyPageViewController())
        vc4.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "My page"), tag: 4)
        self.viewControllers = [vc1, vc2, vc3, vc4]
>>>>>>> Stashed changes
    }
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
}
