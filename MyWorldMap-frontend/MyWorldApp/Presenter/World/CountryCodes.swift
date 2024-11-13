//
//  CountryCodes.swift
//  MergeWithSwiftUI
//
//  Created by 김서현 on 8/17/24.
//

import Foundation

protocol Country {
    var name: String { get }
    var emoji: String { get }
}

protocol City {
    var country: CountryEnum { get }
}

enum CountryEnum: String, CaseIterable {
    // TODO
    /*
    case unitedArabEmirates = "AE"
    case afghanistan = "AF"
    case albania = "AL"
    case armenia = "AM"
    case angola = "AO"
    case argentina = "AR"
    case austria = "AT"
    case australia = "AU"
    case azerbaijan = "AZ"
    case bosniaAndHerzegovina = "BA"
    case bangladesh = "BD"
    case belgium = "BE"
    case burkinaFaso = "BF"
    case bulgaria = "BG"
    case burundi = "BI"
    case benin = "BJ"
    case bruneiDarussalam = "BN"
    case bolivia = "BO"
    case brazil = "BR"
    case bahamas = "BS"
    case bhutan = "BT"
     */
    
    case southKorea             = "KR"
    case vietnam                = "VN"
    case thailand               = "TH"
    case philippines            = "PH"
    case taiwan                 = "TW"
    case indonesia              = "ID"
    case japan                  = "JP"
    case australia              = "AU"
    case china                  = "CN"
    case france                 = "FR"
    case italy                  = "IT"
    case germany                = "DE"
    case unitedKingdom          = "GB"
    case spain                  = "ES"
    case turkey                 = "TR"
    case usa                    = "US"
    case canada                 = "CA"
    case switzerland            = "CH"
    case austria                = "AT"
    case czechRepublic          = "CZ"
    case egypt                  = "EG"
    case mongolia               = "MN"
    case mexico                 = "MX"
    case unitedArabEmirates     = "AE"
    case singapore              = "SG"
    case hongKong               = "HK"
    case macau                  = "MO"
    case newZealand             = "NZ"
}
extension CountryEnum: Country {
    var name: String {
        switch self {
        case .southKorea:           return "한국"
        case .vietnam:              return "베트남"
        case .thailand:             return "태국"
        case .philippines:          return "필리핀"
        case .taiwan:               return "대만"
        case .indonesia:            return "인도네시아"
        case .japan:                return "일본"
        case .australia:            return "호주"
        case .china:                return "중국"
        case .france:               return "프랑스"
        case .italy:                return "이탈리아"
        case .germany:              return "독일"
        case .unitedKingdom:        return "영국"
        case .spain:                return "스페인"
        case .turkey:               return "튀르키예"
        case .usa:                  return "미국"
        case .canada:               return "캐나다"
        case .switzerland:          return "스위스"
        case .austria:              return "오스트리아"
        case .czechRepublic:        return "체코"
        case .egypt:                return "이집트"
        case .mongolia:             return "몽골"
        case .mexico:               return "멕시코"
        case .unitedArabEmirates:   return "아랍에미리트"
        case .singapore:            return "싱가포르"
        case .hongKong:             return "홍콩"
        case .macau:                return "마카오"
        case .newZealand:           return "뉴질랜드"
        }
    }
    
    var emoji: String {
        switch self {
        case .southKorea:           return "🇰🇷"
        case .vietnam:              return "🇻🇳"
        case .thailand:             return "🇹🇭"
        case .philippines:          return "🇵🇭"
        case .taiwan:               return "🇹🇼"
        case .indonesia:            return "🇮🇩"
        case .japan:                return "🇯🇵"
        case .australia:            return "🇦🇺"
        case .china:                return "🇨🇳"
        case .france:               return "🇫🇷"
        case .italy:                return "🇮🇹"
        case .germany:              return "🇩🇪"
        case .unitedKingdom:        return "🇬🇧"
        case .spain:                return "🇪🇸"
        case .turkey:               return "🇹🇷"
        case .usa:                  return "🇺🇸"
        case .canada:               return "🇨🇦"
        case .switzerland:          return "🇨🇭"
        case .austria:              return "🇦🇹"
        case .czechRepublic:        return "🇨🇿"
        case .egypt:                return "🇪🇬"
        case .mongolia:             return "🇲🇳"
        case .mexico:               return "🇲🇽"
        case .unitedArabEmirates:   return "🇦🇪"
        case .singapore:            return "🇸🇬"
        case .hongKong:             return "🇭🇰"
        case .macau:                return "🇲🇴"
        case .newZealand:           return "🇳🇿"
        }
    }
}

enum CityEnum: String, CaseIterable {
    case hanoi          = "하노이"
    case daNang         = "다낭"
    case hoChiMinh      = "호치민"
    case nhaTrang       = "나트랑"
    case bangkok        = "방콕"
    case cebu           = "세부"
    case manila         = "마닐라"
    case singapore      = "싱가포르"
    case taipei         = "타이페이"
    case denfasar       = "덴파사르"
    case osaka          = "오사카"
    case fukuoka        = "후쿠오카"
    case tokyo          = "도쿄"
    case okinawa        = "오키나와"
    case nagoya         = "나고야"
    case brisbane       = "브리즈번"
    case sydney         = "시드니"
    case melbourne      = "멜버른"
    case oakland        = "오클랜드"
    case shanghai       = "상하이"
    case beijing        = "베이징"
    case simcheon       = "심천"
    case guangzhou      = "광저우"
    case cheongdo       = "청도"
    case yeongil        = "연길"
    case paris          = "파리"
    case roma           = "로마"
    case frankfurt      = "프랑크푸르트"
    case london         = "런던"
    case barcelona      = "바르셀로나"
    case istanbul       = "이스탄불"
    case losAngeles     = "로스엔젤러스"
    case newYork        = "뉴욕"
    case vancouver      = "벤쿠버"
    case honolulu       = "호놀룰루"
    case sanFrancisco   = "센프란시스코"
    case guam           = "괌"
    case saipan         = "사이판"
    case toronto        = "토론토"
    case zurich         = "취리히"
    case vienna         = "비엔나"
    case praha          = "프라하"
    case kairo          = "카이로"
    case hongKong       = "홍콩"
    case macao          = "마카오"
    case ulaanbaatar    = "올란바토르"
    case cancun         = "칸쿤"
    case dubai          = "두바이"
}
extension CityEnum: City {
    var country: CountryEnum {
        switch self {
        case .hanoi:            return .vietnam
        case .daNang:           return .vietnam
        case .hoChiMinh:        return .vietnam
        case .nhaTrang:         return .vietnam
        case .bangkok:          return .thailand
        case .cebu:             return .philippines
        case .manila:           return .philippines
        case .singapore:        return .singapore
        case .taipei:           return .taiwan
        case .denfasar:         return .indonesia
        case .osaka:            return .japan
        case .fukuoka:          return .japan
        case .tokyo:            return .japan
        case .okinawa:          return .japan
        case .nagoya:           return .japan
        case .brisbane:         return .australia
        case .sydney:           return .australia
        case .melbourne:        return .australia
        case .oakland:          return .newZealand
        case .shanghai:         return .china
        case .beijing:          return .china
        case .simcheon:         return .china
        case .guangzhou:        return .china
        case .cheongdo:         return .china
        case .yeongil:          return .china
        case .paris:            return .france
        case .roma:             return .italy
        case .frankfurt:        return .germany
        case .london:           return .unitedKingdom
        case .barcelona:        return .spain
        case .istanbul:         return .turkey
        case .losAngeles:       return .usa
        case .newYork:          return .usa
        case .vancouver:        return .usa
        case .honolulu:         return .usa
        case .sanFrancisco:     return .usa
        case .guam:             return .usa
        case .saipan:           return .usa
        case .toronto:          return .canada
        case .zurich:           return .switzerland
        case .vienna:           return .austria
        case .praha:            return .czechRepublic
        case .kairo:            return .egypt
        case .hongKong:         return .china
        case .macao:            return .china
        case .ulaanbaatar:      return .mongolia
        case .cancun:           return .mexico
        case .dubai:            return .unitedArabEmirates
        }
    }
}

/****/
let countryCodes: [String: String] = [
    "한국": "KR",
    "베트남": "VN",
    "태국": "TH",
    "필리핀": "PH",
    "대만": "TW",
    "인도네시아": "ID",
    "일본": "JP",
    "호주": "AU",
    "중국": "CN",
    "프랑스": "FR",
    "이탈리아": "IT",
    "독일": "DE",
    "영국": "GB",
    "스페인": "ES",
    "튀르키예": "TR",
    "미국": "US",
    "캐나다": "CA",
    "스위스": "CH",
    "오스트리아": "AT",
    "체코": "CZ",
    "이집트": "EG",
    "몽골": "MN",
    "멕시코": "MX",
    "아랍에미리트": "AE",
    "싱가포르": "SG"  // 지도에 표시되지 않음
    /*"홍콩": "HK",  // 중국으로 표시될 수 있음
    "마카오": "MO",  // 중국으로 표시될 수 있음*/
]

let countryEmojis: [String: String] = [
    "한국": "🇰🇷",
    "베트남": "🇻🇳",
    "태국": "🇹🇭",
    "필리핀": "🇵🇭",
    "대만": "🇹🇼",
    "인도네시아": "🇮🇩",
    "일본": "🇯🇵",
    "호주": "🇦🇺",
    "중국": "🇨🇳",
    "프랑스": "🇫🇷",
    "이탈리아": "🇮🇹",
    "독일": "🇩🇪",
    "영국": "🇬🇧",
    "스페인": "🇪🇸",
    "튀르키예": "🇹🇷",
    "미국": "🇺🇸",
    "캐나다": "🇨🇦",
    "스위스": "🇨🇭",
    "오스트리아": "🇦🇹",
    "체코": "🇨🇿",
    "이집트": "🇪🇬",
    "몽골": "🇲🇳",
    "멕시코": "🇲🇽",
    "아랍에미리트": "🇦🇪",
    "싱가포르": "🇸🇬",  // 지도에 표시되지 않음
    "홍콩": "🇭🇰",  // 중국으로 표시될 수 있음
    "마카오": "🇲🇴"  // 중국으로 표시될 수 있음
]


let cityIds: [String: Int] = [
    "하노이": 1,
    "다낭": 2,
    "호치민": 3,
    "나트랑": 4,
    "방콕": 5,
    "세부": 6,
    "마닐라": 7,
    "싱가포르": 8,
    "타이페이": 9,
    "덴파사르": 10,
    "오사카": 11,
    "후쿠오카": 12,
    "삿포로": 13,
    "도쿄": 14,
    "오키나와": 15,
    "나고야": 16,
    "브리즈번": 17,
    "시드니": 18,
    "멜버른": 19,
    "오클랜드": 20,
    "상하이": 21,
    "베이징": 22,
    "심천": 23,
    "광저우": 24,
    "청도": 25,
    "연길": 26,
    "파리": 27,
    "로마": 28,
    "프랑크푸르트": 29,
    "런던": 30,
    "바르셀로나": 31,
    "이스탄불": 32,
    "로스엔젤레스": 33,
    "뉴욕": 34,
    "벤쿠버": 35,
    "호놀룰루": 36,
    "센프란시스코": 37,
    "괌": 38,
    "사이판": 39,
    "토론토": 40,
    "취리히": 41,
    "비엔나": 42,
    "프라하": 43,
    "카이로": 44,
    "홍콩": 45,
    "마카오": 46,
    "올란바토르": 47,
    "칸쿤": 48,
    "두바이": 49
]


let findCountry: [Int: String] = [
    1: "베트남",
    2: "베트남",
    3: "베트남",
    4: "베트남",
    5: "태국",
    6: "필리핀",
    7: "필리핀",
    8: "싱가포르",
    9: "대만",
    10: "인도네시아",
    11: "일본",
    12: "일본",
    13: "일본",
    14: "일본",
    15: "일본",
    16: "일본",
    17: "호주",
    18: "호주",
    19: "호주",
    20: "뉴질랜드",
    21: "중국",
    22: "중국",
    23: "중국",
    24: "중국",
    25: "중국",
    26: "중국",
    27: "프랑스",
    28: "이탈리아",
    29: "독일",
    30: "영국",
    31: "스페인",
    32: "튀르키예",
    33: "미국",
    34: "미국",
    35: "미국",
    36: "미국",
    37: "미국",
    38: "미국",
    39: "미국",
    40: "캐나다",
    41: "스위스",
    42: "오스트리아",
    43: "체코",
    44: "이집트",
    45: "중국",
    46: "중국",
    47: "몽골",
    48: "멕시코",
    49: "아랍에미리트"
]
/****/
