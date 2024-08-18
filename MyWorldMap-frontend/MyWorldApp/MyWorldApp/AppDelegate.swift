//
//  AppDelegate.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/23/24.
//
import UIKit
import KakaoSDKCommon
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           // 카카오 SDK 초기화
           KakaoSDK.initSDK(appKey: "b30c067a8e1ee82121d9dad510240fbe")
        GMSServices.provideAPIKey("GOOGLE_MAP_KEY")
           return true
       }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
