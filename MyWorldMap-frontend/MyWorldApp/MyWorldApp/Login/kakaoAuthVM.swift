//
//  kakaoAuthVM.swift
//  MyWorldApp
//
//  Created by 이예성 on 7/29/24.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthVM: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var isLoggedIn : Bool = false
    
    init() {
        print("KakaoAuthVM - init() called")
    }
    
    // 카카오톡 앱으로 로그인 인증
    func kakaoLoginWithApp() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
        
    }
    
    // 카카오 계정으로 로그인
    func kakaoLoginWithAccount() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func KakaoLogin() async -> Bool {
        print("KakaoAuthVM - handleKakaoLogin() called")
        
        return await withCheckedContinuation { continuation in
            Task {
                let loginSuccess: Bool
                // 카카오톡 실행 가능 여부 확인
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    // 카카오톡 앱으로 로그인 인증
                    loginSuccess = await kakaoLoginWithApp()
                } else { // 카카오톡 계정으로 로그인 인증
                    loginSuccess = await kakaoLoginWithAccount()
                }
                // 처리 결과 반환
                continuation.resume(returning: loginSuccess)
            }
        }
    } // KakaoLogin()
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogOut() {
                self.isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogOut() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}

//class KakaoAuthVM: ObservableObject {
//    
//    var subscriptions = Set<AnyCancellable>()
//    
//    @Published var isLoggedIn: Bool = false
//    @Published var errorMessage: String? // 에러 메시지를 저장하는 변수
//    
//    // 사용자 토큰 저장을 위한 변수
//    @Published private(set) var oauthToken: String? {
//        didSet {
//            isLoggedIn = oauthToken != nil
//        }
//    }
//    
//    init() {
//        print("KakaoAuthVM - init() called")
//        loadToken() // 초기화 시 저장된 토큰 로드
//    }
//    
//    // 저장된 토큰을 로드하여 자동 로그인 시도
//    private func loadToken() {
//        if let tokenString = UserDefaults.standard.string(forKey: "kakaoToken") {
//            oauthToken = tokenString
//            isLoggedIn = true
//            print("토큰 로드 성공, 자동 로그인 시도 중")
//        } else {
//            print("저장된 토큰이 없습니다.")
//        }
//    }
//    
//    // 토큰을 안전하게 저장
//    private func saveToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: "kakaoToken")
//        oauthToken = token
//    }
//    
//    // 카카오톡 앱으로 로그인 인증
//    func kakaoLoginWithApp() async -> Bool {
//        await withCheckedContinuation { continuation in
//            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
//                if let error = error {
//                    print(error)
//                    self?.errorMessage = "카카오톡으로 로그인 실패: \(error.localizedDescription)"
//                    continuation.resume(returning: false)
//                } else if let oauthToken = oauthToken {
//                    print("loginWithKakaoTalk() success.")
//                    self?.exchangeTokenWithServer(authCode: oauthToken.accessToken) { success in
//                        continuation.resume(returning: success)
//                    }
//                }
//            }
//        }
//    }
//    
//    // 카카오 계정으로 로그인
//    func kakaoLoginWithAccount() async -> Bool {
//        await withCheckedContinuation { continuation in
//            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
//                if let error = error {
//                    print(error)
//                    self?.errorMessage = "카카오 계정으로 로그인 실패: \(error.localizedDescription)"
//                    continuation.resume(returning: false)
//                } else if let oauthToken = oauthToken {
//                    print("loginWithKakaoAccount() success.")
//                    self?.exchangeTokenWithServer(authCode: oauthToken.accessToken) { success in
//                        continuation.resume(returning: success)
//                    }
//                }
//            }
//        }
//    }
//    
//    @MainActor
//    func KakaoLogin() async -> Bool {
//        print("KakaoAuthVM - KakaoLogin() called")
//        
//        return await withCheckedContinuation { continuation in
//            Task {
//                let loginSuccess: Bool
//                if (UserApi.isKakaoTalkLoginAvailable()) {
//                    loginSuccess = ((try? await kakaoLoginWithApp()) != nil)
//                } else {
//                    loginSuccess = ((try? await kakaoLoginWithAccount()) != nil)
//                }
//                continuation.resume(returning: loginSuccess)
//            }
//        }
//    }
//    
//    @MainActor
//    func kakaoLogout() {
//        Task {
//            if await handleKakaoLogOut() {
//                clearToken() // 로그아웃 시 토큰 삭제
//                self.isLoggedIn = false
//            }
//        }
//    }
//    
//    func handleKakaoLogOut() async -> Bool {
//        await withCheckedContinuation { continuation in
//            UserApi.shared.logout { [weak self] (error) in
//                if let error = error {
//                    print(error)
//                    self?.errorMessage = "로그아웃 실패: \(error.localizedDescription)"
//                    continuation.resume(returning: false)
//                } else {
//                    print("logout() success.")
//                    continuation.resume(returning: true)
//                }
//            }
//        }
//    }
//    
//    // 저장된 토큰을 삭제
//    private func clearToken() {
//        UserDefaults.standard.removeObject(forKey: "kakaoToken")
//        oauthToken = nil
//    }
//    
//    // 서버로 인증 코드 전송 및 토큰 교환
//    private func exchangeTokenWithServer(authCode: String, completion: @escaping (Bool) -> Void) {
//        let url = URL(string: "http://\("API_KEY")/getToken")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
//        
//        let params = "authCode=\(authCode)"
//        request.httpBody = params.data(using: .utf8)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("서버와의 통신 중 오류 발생: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//            
//            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
//                print("잘못된 서버 응답")
//                completion(false)
//                return
//            }
//            
//            print("서버 응답: \(responseString)")
//            self.saveToken(responseString) // 서버에서 받은 토큰을 저장
//            completion(true)
//        }
//        
//        task.resume()
//    }
//}
