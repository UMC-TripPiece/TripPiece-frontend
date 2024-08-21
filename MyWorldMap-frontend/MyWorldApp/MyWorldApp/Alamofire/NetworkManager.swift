//
//  File.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/9/24.
//

//import Alamofire
//import UIKit
//
//class NetworkManager {
//
//    static let shared = NetworkManager()  // 싱글톤 패턴으로 사용
//
//    private init() {}  // 외부에서 인스턴스 생성 방지
//
//    // 여행 기록 데이터와 썸네일 이미지를 POST 요청으로 전송하는 메서드
//    func postTravelData(cityName: String, countryName: String, title: String, startDate: Date, endDate: Date, thumbnail: UIImage, completion: @escaping (Result<Any, Error>) -> Void) {
//        let url = "http://\("API_KEY")/mytravels"
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        // JSON 데이터 준비
//        let parameters: [String: Any] = [
//            "cityName": cityName,
//            "countryName": countryName,
//            "title": title,
//            "startDate": dateFormatter.string(from: startDate),
//            "endDate": dateFormatter.string(from: endDate)
//        ]
//
//        // 이미지 데이터 준비
//        guard let imageData = thumbnail.jpegData(compressionQuality: 0.8) else {
//            print("이미지 준비 실패")
//            return
//        }
//
//        AF.upload(multipartFormData: { multipartFormData in
//            // JSON 데이터를 추가
//            for (key, value) in parameters {
//                if let valueString = value as? String {
//                    multipartFormData.append(valueString.data(using: .utf8)!, withName: key)
//                }
//            }
//
//            // 이미지 데이터를 추가
//            multipartFormData.append(imageData, withName: "thumbnail", fileName: "thumbnail.jpg", mimeType: "image/jpeg")
//
//        }, to: url).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                completion(.success(value))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()  // 싱글톤 패턴으로 사용

    private init() {}  // 외부에서 인스턴스 생성 방지
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    // 여행 기록 데이터와 썸네일 이미지를 POST 요청으로 전송하는 메서드
    func postTravelData(cityName: String, countryName: String, title: String, startDate: Date, endDate: Date, thumbnail: UIImage, completion: @escaping (Result<Any, Error>) -> Void) {
        let url = "http://3.34.123.244:8080/mytravels"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // JSON 데이터 준비
        let parameters: [String: Any] = [
            "cityName": cityName,
            "countryName": countryName,
            "title": title,
            "startDate": dateFormatter.string(from: startDate),
            "endDate": dateFormatter.string(from: endDate)
        ]
        
        // 이미지 데이터 준비
        guard let imageData = thumbnail.jpegData(compressionQuality: 0.8) else {
            print("이미지 준비 실패")
            return
        }
        
        // JSON 데이터를 직렬화
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("JSON 직렬화 실패")
            return
        }
        
        // 리프레시 토큰 가져오기
        guard let refreshToken = getRefreshToken() else {
            print("리프레시 토큰이 없습니다.")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            // JSON 데이터를 'data' 필드로 추가
            multipartFormData.append(jsonData, withName: "data", mimeType: "application/json")
            
            // 이미지 데이터를 'thumbnail' 필드로 추가
            multipartFormData.append(imageData, withName: "thumbnail", fileName: "thumbnail.jpg", mimeType: "image/jpeg")
            
        }, to: url, headers: [
            "Authorization": "Bearer \(refreshToken)",  // Authorization 헤더 추가
            "Content-Type": "multipart/form-data"
        ]).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
