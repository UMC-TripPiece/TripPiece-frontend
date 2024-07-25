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

    private func setTabBar() {
        let vc1 = UINavigationController(rootViewController: WorldViewController())
        vc1.tabBarItem = UITabBarItem(title: "월드", image: UIImage(named: "World"), tag: 1)
        let vc2 = MyLogViewController()
        vc2.tabBarItem = UITabBarItem(title: "나의 기록", image: UIImage(named: "My log"), tag: 2)
        let vc3 = SearchViewController()
        vc3.tabBarItem = UITabBarItem(title: "탐색", image: UIImage(named: "Search"), tag: 3)
        let vc4 = MyPageViewController()
        vc4.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "My page"), tag: 4)
        self.viewControllers = [vc1, vc2, vc3, vc4]
    }

    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.configureWithOpaqueBackground()

        // 아이콘 기본 색상 설정
        barAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "Not selected")

        self.tabBar.standardAppearance = barAppearance
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.masksToBounds = false
        self.tabBar.tintColor = UIColor(named: "Main")
        self.tabBar.backgroundColor = .white

        // 그림자 설정
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.2
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.tabBar.layer.shadowRadius = 10

        // 탭바 아이템 위치 조정
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 55
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabFrame = tabBar.frame
        tabFrame.size.height = 100
        tabFrame.origin.y = view.frame.size.height - 100
        tabBar.frame = tabFrame
    }
}
