//
//  TravelInfo.swift
//  MyWorldApp
//
//  Created by 김나연 on 8/18/24.
//

import UIKit

struct TravelInfo {
    var cityName: String?
    var countryName: String?
    var title: String?
    var startDate: Date?
    var endDate: Date?
    var thumbnail: UIImage?
    
    mutating func updateInfo(cityName: String? = nil,
                                 countryName: String? = nil,
                                 title: String? = nil,
                                 startDate: Date? = nil,
                                 endDate: Date? = nil,
                                 thumbnail: UIImage? = nil) {
        if let cityName = cityName {
            self.cityName = cityName
        }
        if let countryName = countryName {
            self.countryName = countryName
        }
        if let title = title {
            self.title = title
        }
        if let startDate = startDate {
            self.startDate = startDate
        }
        if let endDate = endDate {
            self.endDate = endDate
        }
        if let thumbnail = thumbnail {
            self.thumbnail = thumbnail
        }
    }
}
