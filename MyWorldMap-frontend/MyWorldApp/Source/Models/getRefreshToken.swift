//
//  getRefreshToken.swift
//  MyWorldApp
//
//  Created by 이예성 on 11/12/24.
//

class getRefreshToken {
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
}
