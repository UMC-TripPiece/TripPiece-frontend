//
//  File.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/9/24.
//

import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()  // 싱글톤 패턴으로 사용

    private init() {}  // 외부에서 인스턴스 생성 방지
    
    // 여행 기록 데이터와 썸네일 이미지를 POST 요청으로 전송하는 메서드
    func postTravelData(cityName: String, countryName: String, title: String, startDate: Date, endDate: Date, thumbnail: UIImage, completion: @escaping (Result<Any, Error>) -> Void) {
        let url = "http://\("API_KEY")/mytravels"
        
        let dateFormatter = ISO8601DateFormatter()
        
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
        
        AF.upload(multipartFormData: { multipartFormData in
            // JSON 데이터를 추가
            for (key, value) in parameters {
                if let valueString = value as? String {
                    multipartFormData.append(valueString.data(using: .utf8)!, withName: key)
                }
            }
            
            // 이미지 데이터를 추가
            multipartFormData.append(imageData, withName: "thumbnail", fileName: "thumbnail.jpg", mimeType: "image/jpeg")
            
        }, to: url).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
