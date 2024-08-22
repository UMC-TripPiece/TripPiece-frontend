//
//  ViewModel.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/18/24.
//

import SwiftUI
import Combine
import InteractiveMap

class MapViewModel: ObservableObject {
    @Published var selectedCountry = PathData()
    @Published var selectedCountryName = String()
    @Published var isSelected = false
    @Published var countryIndex: [String: PathData] = [:]
    
    func zoomToCountry(_ countryName: String) {
        self.isSelected = true
        self.selectedCountryName = countryName
        print("받아온 나라이름: \(countryName)")
        print("저장된 나라이름: \(self.selectedCountryName)")
        print("isSelected 상태: \(self.isSelected)")
    }
}


class UserCountryColorsModel: ObservableObject {
    @Published var userSavedCountryColors: [String: String] = [:]
}
