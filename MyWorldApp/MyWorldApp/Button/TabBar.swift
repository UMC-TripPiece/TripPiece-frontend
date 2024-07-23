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
    }
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
}
