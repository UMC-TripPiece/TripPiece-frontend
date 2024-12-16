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
    case andorra = "AD"
    case unitedArabEmirates = "AE"
    case afghanistan = "AF"
    case antiguaAndBarbuda = "AG"
    case anguilla = "AI"
    case albania = "AL"
    case armenia = "AM"
    case angola = "AO"
    case argentina = "AR"
    case americanSamoa = "AS"
    case austria = "AT"
    case australia = "AU"
    case aruba = "AW"
    case alandIslands = "AX"
    case azerbaijan = "AZ"
    case bosniaAndHerzegovina = "BA"
    case barbados = "BB"
    case bangladesh = "BD"
    case belgium = "BE"
    case burkinaFaso = "BF"
    case bulgaria = "BG"
    case bahrain = "BH"
    case burundi = "BI"
    case benin = "BJ"
    case saintBarthelemy = "BL"
    case bruneiDarussalam = "BN"
    case bolivia = "BO"
    case bermuda = "BM"
    case caribbeanNetherlands = "BQ" // Bonaire,  Saint Eustachius and Saba
    case brazil = "BR"
    case bahamas = "BS"
    case bhutan = "BT"
    case bouvetIsland = "BV"
    case botswana = "BW"
    case belarus = "BY"
    case belize = "BZ"
    case canada = "CA"
    case cocosKeelingIslands = "CC"
    case democraticRepublicOfCongo = "CD"
    case centralAfricanRepublic = "CF"
    case republicOfCongo = "CG"
    case switzerland = "CH"
    case ivoryCoast = "CI" // Côte d'Ivoire
    case cookIslands = "CK"
    case chile = "CL"
    case cameroon = "CM"
    case china = "CN"
    case colombia = "CO"
    case costaRica = "CR"
    case cuba = "CU"
    case capeVerde = "CV"
    case curacao = "CW" // curaçao
    case christmasIsland = "CX"
    case cyprus = "CY"
    case czechRepublic = "CZ"
    case germany = "DE"
    case djibouti = "DJ"
    case denmark = "DK"
    case dominica = "DM"
    case dominicanRepublic = "DO"
    case algeria = "DZ"
    case ecuador = "EC"
    case egypt = "EG"
    case estonia = "EE"
    case westernSahara = "EH"
    case eritrea = "ER"
    case spain = "ES"
    case ethiopia = "ET"
    case finland = "FI"
    case fiji = "FJ"
    case falklandIslands = "FK"
    case federatedStatesOfMicronesia = "FM"
    case faroeIslands = "FO"
    case france = "FR"
    case gabon = "GA"
    case unitedKingdom = "GB"
    case georgia = "GE"
    case grenada = "GD"
    case frenchGuiana = "GF"
    case guernsey = "GG"
    case ghana = "GH"
    case gibraltar = "GI"
    case greenland = "GL"
    case gambia = "GM"
    case guinea = "GN"
    case gloriosoIslands = "GO"
    case guadeloupe = "GP"
    case equatorialGuinea = "GQ"
    case greece = "GR"
    case southGeorgiaAndSouthSandwichIslands = "GS"
    case guatemala = "GT"
    case guam = "GU"
    case guineaBissau = "GW"
    case guyana = "GY"
    case hongKong = "HK"
    case heardIslandAndMcDonaldIslands = "HM"
    case honduras = "HN"
    case croatia = "HR"
    case haiti = "HT"
    case hungary = "HU"
    case indonesia = "ID"
    case ireland = "IE"
    case israel = "IL"
    case isleOfMan = "IM"
    case india = "IN"
    case britishIndianOceanTerritory = "IO"
    case iraq = "IQ"
    case iran = "IR"
    case iceland = "IS"
    case italy = "IT"
    case jersey = "JE"
    case jamaica = "JM"
    case jordan = "JO"
    case japan = "JP"
    case juanDeNovaIsland = "JU"
    case kenya = "KE"
    case kyrgyzstan = "KG"
    case cambodia = "KH"
    case kiribati = "KI"
    case comoros = "KM"
    case saintKittsAndNevis = "KN"
    case northKorea = "KP"
    case southKorea = "KR"
    case kosovo = "XK"
    case kuwait = "KW"
    case caymanIslands = "KY"
    case kazakhstan = "KZ"
    case laos = "LA"
    case lebanon = "LB"
    case saintLucia = "LC"
    case liechtenstein = "LI"
    case sriLanka = "LK"
    case liberia = "LR"
    case lesotho = "LS"
    case lithuania = "LT"
    case luxembourg = "LU"
    case latvia = "LV"
    case libya = "LY"
    case morocco = "MA"
    case monaco = "MC"
    case moldova = "MD"
    case madagascar = "MG"
    case montenegro = "ME"
    case saintMartin = "MF"
    case marshallIslands = "MH"
    case macedonia = "MK"
    case mali = "ML"
    case macau = "MO"
    case myanmar = "MM"
    case mongolia = "MN"
    case northernMarianaIslands = "MP"
    case martinique = "MQ"
    case mauritania = "MR"
    case montserrat = "MS"
    case malta = "MT"
    case mauritius = "MU"
    case maldives = "MV"
    case malawi = "MW"
    case mexico = "MX"
    case malaysia = "MY"
    case mozambique = "MZ"
    case namibia = "NA"
    case newCaledonia = "NC"
    case niger = "NE"
    case norfolkIsland = "NF"
    case nigeria = "NG"
    case nicaragua = "NI"
    case netherlands = "NL"
    case norway = "NO"
    case nepal = "NP"
    case nauru = "NR"
    case niue = "NU"
    case newZealand = "NZ"
    case oman = "OM"
    case panama = "PA"
    case peru = "PE"
    case frenchPolynesia = "PF"
    case papuaNewGuinea = "PG"
    case philippines = "PH"
    case pakistan = "PK"
    case poland = "PL"
    case saintPierreAndMiquelon = "PM"
    case pitcairnIslands = "PN"
    case puertoRico = "PR"
    case palestinianTerritories = "PS"
    case portugal = "PT"
    case palau = "PW"
    case paraguay = "PY"
    case qatar = "QA"
    case reunion = "RE"
    case romania = "RO"
    case serbia = "RS"
    case russia = "RU"
    case rwanda = "RW"
    case saudiArabia = "SA"
    case solomonIslands = "SB"
    case seychelles = "SC"
    case sudan = "SD"
    case sweden = "SE"
    case singapore = "SG"
    case saintHelena = "SH"
    case slovenia = "SI"
    case svalbardAndJanMayen = "SJ"
    case slovakia = "SK"
    case sierraLeone = "SL"
    case sanMarino = "SM"
    case senegal = "SN"
    case somalia = "SO"
    case suriname = "SR"
    case southSudan = "SS"
    case saoTomeAndPrincipe = "ST"
    case elSalvador = "SV"
    case sintMaarten  = "SX"
    case syria = "SY"
    case swaziland = "SZ"
    case turksAndCaicosIslands = "TC"
    case chad = "TD"
    case frenchSouthernAndAntarcticLands = "TF"
    case togo = "TG"
    case thailand = "TH"
    case tajikistan = "TJ"
    case tokelau = "TK"
    case timorLeste = "TL"
    case turkmenistan = "TM"
    case tunisia = "TN"
    case tonga = "TO"
    case turkey = "TR"
    case trinidadAndTobago = "TT"
    case tuvalu = "TV"
    case taiwan = "TW"
    case tanzania = "TZ"
    case ukraine = "UA"
    case uganda = "UG"
    case jarvisIsland = "UM-DQ"
    case bakerIsland = "UM-FQ"
    case howlandIsland = "UM-HQ"
    case johnstonAtoll = "UM-JQ"
    case midwayIslands = "UM-MQ"
    case wakeIsland = "UM-WQ"
    case unitedStates = "US"
    case uruguay = "UY"
    case uzbekistan = "UZ"
    case vaticanCity = "VA"
    case saintVincentAndTheGrenadines = "VC"
    case venezuela = "VE"
    case britishVirginIslands = "VG"
    case usVirginIslands = "VI"
    case vietnam = "VN"
    case vanuatu = "VU"
    case wallisAndFutuna = "WF"
    case samoa = "WS"
    case yemen = "YE"
    case mayotte = "YT"
    case southAfrica = "ZA"
    case zambia = "ZM"
    case zimbabwe = "ZW"
}
extension CountryEnum: Country {
    var name: String {
        switch self {
        case .andorra:                              return "안도라"
        case .unitedArabEmirates:                   return "아랍에미리트"
        case .afghanistan:                          return "아프가니스탄"
        case .antiguaAndBarbuda:                    return "앤티가 바부다"
        case .anguilla:                             return "앵귈라"
        case .albania:                              return "알바니아"
        case .armenia:                              return "아르메니아"
        case .angola:                               return "앙골라"
        case .argentina:                            return "아르헨티나"
        case .americanSamoa:                        return "아메리칸사모아"
        case .austria:                              return "오스트리아"
        case .australia:                            return "오스트레일리아"
        case .aruba:                                return "아루바"
        case .alandIslands:                         return "올란드 제도"
        case .azerbaijan:                           return "아제르바이잔"
        case .bosniaAndHerzegovina:                 return "보스니아 헤르체고비나"
        case .barbados:                             return "바베이도스"
        case .bangladesh:                           return "방글라데시"
        case .belgium:                              return "벨기에"
        case .burkinaFaso:                          return "부르키나파소"
        case .bulgaria:                             return "불가리아"
        case .bahrain:                              return "바레인"
        case .burundi:                              return "부룬디"
        case .benin:                                return "베냉"
        case .saintBarthelemy:                      return "생바르텔레미"
        case .bruneiDarussalam:                     return "브루나이"
        case .bolivia:                              return "볼리비아"
        case .bermuda:                              return "버뮤다"
        case .caribbeanNetherlands:                 return "카리브 네덜란드"
        case .brazil:                               return "브라질"
        case .bahamas:                              return "바하마"
        case .bhutan:                               return "부탄"
        case .bouvetIsland:                         return "부베섬"
        case .botswana:                             return "보츠와나"
        case .belarus:                              return "벨라루스"
        case .belize:                               return "벨리즈"
        case .canada:                               return "캐나다"
        case .cocosKeelingIslands:                  return "코코스 제도"
        case .democraticRepublicOfCongo:            return "콩고 민주 공화국"
        case .centralAfricanRepublic:               return "중앙아프리카 공화국"
        case .republicOfCongo:                      return "콩고 공화국"
        case .switzerland:                          return "스위스"
        case .ivoryCoast:                           return "코트디부아르"
        case .cookIslands:                          return "쿡 제도"
        case .chile:                                return "칠레"
        case .cameroon:                             return "카메룬"
        case .china:                                return "중국"
        case .colombia:                             return "콜롬비아"
        case .costaRica:                            return "코스타리카"
        case .cuba:                                 return "쿠바"
        case .capeVerde:                            return "카보베르데"
        case .curacao:                              return "퀴라소"
        case .christmasIsland:                      return "크리스마스섬"
        case .cyprus:                               return "키프로스"
        case .czechRepublic:                        return "체코"
        case .germany:                              return "독일"
        case .djibouti:                             return "지부티"
        case .denmark:                              return "덴마크"
        case .dominica:                             return "도미니카 연방"
        case .dominicanRepublic:                    return "도미니카 공화국"
        case .algeria:                              return "알제리"
        case .ecuador:                              return "에콰도르"
        case .egypt:                                return "이집트"
        case .estonia:                              return "에스토니아"
        case .westernSahara:                        return "서사하라"
        case .eritrea:                              return "에리트레아"
        case .spain:                                return "스페인"
        case .ethiopia:                             return "에티오피아"
        case .finland:                              return "핀란드"
        case .fiji:                                 return "피지"
        case .falklandIslands:                      return "포클랜드 제도"
        case .federatedStatesOfMicronesia:          return "미크로네시아 연방"
        case .faroeIslands:                         return "페로 제도"
        case .france:                               return "프랑스"
        case .gabon:                                return "가봉"
        case .unitedKingdom:                        return "영국"
        case .georgia:                              return "조지아"
        case .grenada:                              return "그레나다"
        case .frenchGuiana:                         return "프랑스령 기아나"
        case .guernsey:                             return "건지섬"
        case .ghana:                                return "가나"
        case .gibraltar:                            return "지브롤터"
        case .greenland:                            return "그린란드"
        case .gambia:                               return "감비아"
        case .guinea:                               return "기니"
        case .gloriosoIslands:                      return "글로리오소 제도"
        case .guadeloupe:                           return "과들루프"
        case .equatorialGuinea:                     return "적도 기니"
        case .greece:                               return "그리스"
        case .southGeorgiaAndSouthSandwichIslands:  return "사우스조지아 사우스샌드위치 제도"
        case .guatemala:                            return "과테말라"
        case .guam:                                 return "괌"
        case .guineaBissau:                         return "기니비사우"
        case .guyana:                               return "가이아나"
        case .hongKong:                             return "홍콩"
        case .heardIslandAndMcDonaldIslands:        return "허드 맥도널드 제도"
        case .honduras:                             return "온두라스"
        case .croatia:                              return "크로아티아"
        case .haiti:                                return "아이티"
        case .hungary:                              return "헝가리"
        case .indonesia:                            return "인도네시아"
        case .ireland:                              return "아일랜드"
        case .israel:                               return "이스라엘"
        case .isleOfMan:                            return "맨섬"
        case .india:                                return "인도"
        case .britishIndianOceanTerritory:          return "영국령 인도양 지역"
        case .iraq:                                 return "이라크"
        case .iran:                                 return "이란"
        case .iceland:                              return "아이슬란드"
        case .italy:                                return "이탈리아"
        case .jersey:                               return "저지섬"
        case .jamaica:                              return "자메이카"
        case .jordan:                               return "요르단"
        case .japan:                                return "일본"
        case .juanDeNovaIsland:                     return "후안 데 노바 섬"
        case .kenya:                                return "케냐"
        case .kyrgyzstan:                           return "키르기스스탄"
        case .cambodia:                             return "캄보디아"
        case .kiribati:                             return "키리바시"
        case .comoros:                              return "코모로"
        case .saintKittsAndNevis:                   return "세인트키츠 네비스"
        case .northKorea:                           return "조선민주주의인민공화국"
        case .southKorea:                           return "대한민국"
        case .kosovo:                               return "코소보"
        case .kuwait:                               return "쿠웨이트"
        case .caymanIslands:                        return "케이맨 제도"
        case .kazakhstan:                           return "카자흐스탄"
        case .laos:                                 return "라오스"
        case .lebanon:                              return "레바논"
        case .saintLucia:                           return "세인트루시아"
        case .liechtenstein:                        return "리히텐슈타인"
        case .sriLanka:                             return "스리랑카"
        case .liberia:                              return "라이베리아"
        case .lesotho:                              return "레소토"
        case .lithuania:                            return "리투아니아"
        case .luxembourg:                           return "룩셈부르크"
        case .latvia:                               return "라트비아"
        case .libya:                                return "리비아"
        case .morocco:                              return "모로코"
        case .monaco:                               return "모나코"
        case .moldova:                              return "몰도바"
        case .madagascar:                           return "마다가스카르"
        case .montenegro:                           return "몬테네그로"
        case .saintMartin:                          return "생마르탱"
        case .marshallIslands:                      return "마셜 제도"
        case .macedonia:                            return "북마케도니아"
        case .mali:                                 return "말리"
        case .macau:                                return "마카오"
        case .myanmar:                              return "미얀마"
        case .mongolia:                             return "몽골"
        case .northernMarianaIslands:               return "북마리아나 제도"
        case .martinique:                           return "마르티니크"
        case .mauritania:                           return "모리타니"
        case .montserrat:                           return "몬트세랫"
        case .malta:                                return "몰타"
        case .mauritius:                            return "모리셔스"
        case .maldives:                             return "몰디브"
        case .malawi:                               return "말라위"
        case .mexico:                               return "멕시코"
        case .malaysia:                             return "말레이시아"
        case .mozambique:                           return "모잠비크"
        case .namibia:                              return "나미비아"
        case .newCaledonia:                         return "누벨칼레도니"
        case .niger:                                return "니제르"
        case .norfolkIsland:                        return "노퍽섬"
        case .nigeria:                              return "나이지리아"
        case .nicaragua:                            return "니카라과"
        case .netherlands:                          return "네덜란드"
        case .norway:                               return "노르웨이"
        case .nepal:                                return "네팔"
        case .nauru:                                return "나우루"
        case .niue:                                 return "니우에"
        case .newZealand:                           return "뉴질랜드"
        case .oman:                                 return "오만"
        case .panama:                               return "파나마"
        case .peru:                                 return "페루"
        case .frenchPolynesia:                      return "프랑스령 폴리네시아"
        case .papuaNewGuinea:                       return "파푸아뉴기니"
        case .philippines:                          return "필리핀"
        case .pakistan:                             return "파키스탄"
        case .poland:                               return "폴란드"
        case .saintPierreAndMiquelon:               return "생피에르 미클롱"
        case .pitcairnIslands:                      return "핏케언 제도"
        case .puertoRico:                           return "푸에르토리코"
        case .palestinianTerritories:               return "팔레스타인"
        case .portugal:                             return "포르투갈"
        case .palau:                                return "팔라우"
        case .paraguay:                             return "파라과이"
        case .qatar:                                return "카타르"
        case .reunion:                              return "레위니옹"
        case .romania:                              return "루마니아"
        case .serbia:                               return "세르비아"
        case .russia:                               return "러시아"
        case .rwanda:                               return "르완다"
        case .saudiArabia:                          return "사우디아라비아"
        case .solomonIslands:                       return "솔로몬 제도"
        case .seychelles:                           return "세이셸"
        case .sudan:                                return "수단"
        case .sweden:                               return "스웨덴"
        case .singapore:                            return "싱가포르"
        case .saintHelena:                          return "세인트헬레나"
        case .slovenia:                             return "슬로베니아"
        case .svalbardAndJanMayen:                  return "스발바르 얀마옌"
        case .slovakia:                             return "슬로바키아"
        case .sierraLeone:                          return "시에라리온"
        case .sanMarino:                            return "산마리노"
        case .senegal:                              return "세네갈"
        case .somalia:                              return "소말리아"
        case .suriname:                             return "수리남"
        case .southSudan:                           return "남수단"
        case .saoTomeAndPrincipe:                   return "상투메 프린시페"
        case .elSalvador:                           return "엘살바도르"
        case .sintMaarten:                          return "신트마르턴"
        case .syria:                                return "시리아"
        case .swaziland:                            return "에스와티니"
        case .turksAndCaicosIslands:                return "터크스 케이커스 제도"
        case .chad:                                 return "차드"
        case .frenchSouthernAndAntarcticLands:      return "프랑스령 남방 및 남극 지역"
        case .togo:                                 return "토고"
        case .thailand:                             return "태국"
        case .tajikistan:                           return "타지키스탄"
        case .tokelau:                              return "토켈라우"
        case .timorLeste:                           return "동티모르"
        case .turkmenistan:                         return "투르크메니스탄"
        case .tunisia:                              return "튀니지"
        case .tonga:                                return "통가"
        case .turkey:                               return "튀르키예"
        case .trinidadAndTobago:                    return "트리니다드 토바고"
        case .tuvalu:                               return "투발루"
        case .taiwan:                               return "중화민국"
        case .tanzania:                             return "탄자니아"
        case .ukraine:                              return "우크라이나"
        case .uganda:                               return "우간다"
        case .jarvisIsland:                         return "자르비스섬"
        case .bakerIsland:                          return "베이커섬"
        case .howlandIsland:                        return "하울랜드섬"
        case .johnstonAtoll:                        return "존스턴 환초"
        case .midwayIslands:                        return "미드웨이 제도"
        case .wakeIsland:                           return "웨이크섬"
        case .unitedStates:                         return "미국"
        case .uruguay:                              return "우루과이"
        case .uzbekistan:                           return "우즈베키스탄"
        case .vaticanCity:                          return "바티칸 시국"
        case .saintVincentAndTheGrenadines:         return "세인트빈센트 그레나딘"
        case .venezuela:                            return "베네수엘라"
        case .britishVirginIslands:                 return "영국령 버진아일랜드"
        case .usVirginIslands:                      return "미국령 버진아일랜드"
        case .vietnam:                              return "베트남"
        case .vanuatu:                              return "바누아투"
        case .wallisAndFutuna:                      return "왈리스 푸투나"
        case .samoa:                                return "사모아"
        case .yemen:                                return "예멘"
        case .mayotte:                              return "마요트"
        case .southAfrica:                          return "남아프리카 공화국"
        case .zambia:                               return "잠비아"
        case .zimbabwe:                             return "짐바브웨"
        }
    }
    
    var emoji: String {
        switch self {
        case .andorra:                              return "🇦🇩"
        case .unitedArabEmirates:                   return "🇦🇪"
        case .afghanistan:                          return "🇦🇫"
        case .antiguaAndBarbuda:                    return "🇦🇬"
        case .anguilla:                             return "🇦🇮"
        case .albania:                              return "🇦🇱"
        case .armenia:                              return "🇦🇲"
        case .angola:                               return "🇦🇴"
        case .argentina:                            return "🇦🇷"
        case .americanSamoa:                        return "🇦🇸"
        case .austria:                              return "🇦🇹"
        case .australia:                            return "🇦🇺"
        case .aruba:                                return "🇦🇼"
        case .alandIslands:                         return "🇦🇽"
        case .azerbaijan:                           return "🇦🇿"
        case .bosniaAndHerzegovina:                 return "🇧🇦"
        case .barbados:                             return "🇧🇧"
        case .bangladesh:                           return "🇧🇩"
        case .belgium:                              return "🇧🇪"
        case .burkinaFaso:                          return "🇧🇫"
        case .bulgaria:                             return "🇧🇬"
        case .bahrain:                              return "🇧🇭"
        case .burundi:                              return "🇧🇮"
        case .benin:                                return "🇧🇯"
        case .saintBarthelemy:                      return "🇧🇱"
        case .bruneiDarussalam:                     return "🇧🇳"
        case .bolivia:                              return "🇧🇴"
        case .bermuda:                              return "🇧🇲"
        case .caribbeanNetherlands:                 return "🇧🇶"
        case .brazil:                               return "🇧🇷"
        case .bahamas:                              return "🇧🇸"
        case .bhutan:                               return "🇧🇹"
        case .bouvetIsland:                         return "🇧🇻"
        case .botswana:                             return "🇧🇼"
        case .belarus:                              return "🇧🇾"
        case .belize:                               return "🇧🇿"
        case .canada:                               return "🇨🇦"
        case .cocosKeelingIslands:                  return "🇨🇨"
        case .democraticRepublicOfCongo:            return "🇨🇩"
        case .centralAfricanRepublic:               return "🇨🇫"
        case .republicOfCongo:                      return "🇨🇬"
        case .switzerland:                          return "🇨🇭"
        case .ivoryCoast:                           return "🇨🇮"
        case .cookIslands:                          return "🇨🇰"
        case .chile:                                return "🇨🇱"
        case .cameroon:                             return "🇨🇲"
        case .china:                                return "🇨🇳"
        case .colombia:                             return "🇨🇴"
        case .costaRica:                            return "🇨🇷"
        case .cuba:                                 return "🇨🇺"
        case .capeVerde:                            return "🇨🇻"
        case .curacao:                              return "🇨🇼"
        case .christmasIsland:                      return "🇨🇽"
        case .cyprus:                               return "🇨🇾"
        case .czechRepublic:                        return "🇨🇿"
        case .germany:                              return "🇩🇪"
        case .djibouti:                             return "🇩🇯"
        case .denmark:                              return "🇩🇰"
        case .dominica:                             return "🇩🇲"
        case .dominicanRepublic:                    return "🇩🇴"
        case .algeria:                              return "🇩🇿"
        case .ecuador:                              return "🇪🇨"
        case .egypt:                                return "🇪🇬"
        case .estonia:                              return "🇪🇪"
        case .westernSahara:                        return "🇪🇭"
        case .eritrea:                              return "🇪🇷"
        case .spain:                                return "🇪🇸"
        case .ethiopia:                             return "🇪🇹"
        case .finland:                              return "🇫🇮"
        case .fiji:                                 return "🇫🇯"
        case .falklandIslands:                      return "🇫🇰"
        case .federatedStatesOfMicronesia:          return "🇫🇲"
        case .faroeIslands:                         return "🇫🇴"
        case .france:                               return "🇫🇷"
        case .gabon:                                return "🇬🇦"
        case .unitedKingdom:                        return "🇬🇧"
        case .georgia:                              return "🇬🇪"
        case .grenada:                              return "🇬🇩"
        case .frenchGuiana:                         return "🇬🇫"
        case .guernsey:                             return "🇬🇬"
        case .ghana:                                return "🇬🇭"
        case .gibraltar:                            return "🇬🇮"
        case .greenland:                            return "🇬🇱"
        case .gambia:                               return "🇬🇲"
        case .guinea:                               return "🇬🇳"
        case .gloriosoIslands:                      return "🇹🇫"
        case .guadeloupe:                           return "🇬🇵"
        case .equatorialGuinea:                     return "🇬🇶"
        case .greece:                               return "🇬🇷"
        case .southGeorgiaAndSouthSandwichIslands:  return "🇬🇸"
        case .guatemala:                            return "🇬🇹"
        case .guam:                                 return "🇬🇺"
        case .guineaBissau:                         return "🇬🇼"
        case .guyana:                               return "🇬🇾"
        case .hongKong:                             return "🇭🇰"
        case .heardIslandAndMcDonaldIslands:        return "🇭🇲"
        case .honduras:                             return "🇭🇳"
        case .croatia:                              return "🇭🇷"
        case .haiti:                                return "🇭🇹"
        case .hungary:                              return "🇭🇺"
        case .indonesia:                            return "🇮🇩"
        case .ireland:                              return "🇮🇪"
        case .israel:                               return "🇮🇱"
        case .isleOfMan:                            return "🇮🇲"
        case .india:                                return "🇮🇳"
        case .britishIndianOceanTerritory:          return "🇮🇴"
        case .iraq:                                 return "🇮🇶"
        case .iran:                                 return "🇮🇷"
        case .iceland:                              return "🇮🇸"
        case .italy:                                return "🇮🇹"
        case .jersey:                               return "🇯🇪"
        case .jamaica:                              return "🇯🇲"
        case .jordan:                               return "🇯🇴"
        case .japan:                                return "🇯🇵"
        case .juanDeNovaIsland:                     return "🇹🇫"
        case .kenya:                                return "🇰🇪"
        case .kyrgyzstan:                           return "🇰🇬"
        case .cambodia:                             return "🇰🇭"
        case .kiribati:                             return "🇰🇮"
        case .comoros:                              return "🇰🇲"
        case .saintKittsAndNevis:                   return "🇰🇳"
        case .northKorea:                           return "🇰🇵"
        case .southKorea:                           return "🇰🇷"
        case .kosovo:                               return "🇽🇰"
        case .kuwait:                               return "🇰🇼"
        case .caymanIslands:                        return "🇰🇾"
        case .kazakhstan:                           return "🇰🇿"
        case .laos:                                 return "🇱🇦"
        case .lebanon:                              return "🇱🇧"
        case .saintLucia:                           return "🇱🇨"
        case .liechtenstein:                        return "🇱🇮"
        case .sriLanka:                             return "🇱🇰"
        case .liberia:                              return "🇱🇷"
        case .lesotho:                              return "🇱🇸"
        case .lithuania:                            return "🇱🇹"
        case .luxembourg:                           return "🇱🇺"
        case .latvia:                               return "🇱🇻"
        case .libya:                                return "🇱🇾"
        case .morocco:                              return "🇲🇦"
        case .monaco:                               return "🇲🇨"
        case .moldova:                              return "🇲🇩"
        case .madagascar:                           return "🇲🇬"
        case .montenegro:                           return "🇲🇪"
        case .saintMartin:                          return "🇲🇫"
        case .marshallIslands:                      return "🇲🇭"
        case .macedonia:                            return "🇲🇰"
        case .mali:                                 return "🇲🇱"
        case .macau:                                return "🇲🇴"
        case .myanmar:                              return "🇲🇲"
        case .mongolia:                             return "🇲🇳"
        case .northernMarianaIslands:               return "🇲🇵"
        case .martinique:                           return "🇲🇶"
        case .mauritania:                           return "🇲🇷"
        case .montserrat:                           return "🇲🇸"
        case .malta:                                return "🇲🇹"
        case .mauritius:                            return "🇲🇺"
        case .maldives:                             return "🇲🇻"
        case .malawi:                               return "🇲🇼"
        case .mexico:                               return "🇲🇽"
        case .malaysia:                             return "🇲🇾"
        case .mozambique:                           return "🇲🇿"
        case .namibia:                              return "🇳🇦"
        case .newCaledonia:                         return "🇳🇨"
        case .niger:                                return "🇳🇪"
        case .norfolkIsland:                        return "🇳🇫"
        case .nigeria:                              return "🇳🇬"
        case .nicaragua:                            return "🇳🇮"
        case .netherlands:                          return "🇳🇱"
        case .norway:                               return "🇳🇴"
        case .nepal:                                return "🇳🇵"
        case .nauru:                                return "🇳🇷"
        case .niue:                                 return "🇳🇺"
        case .newZealand:                           return "🇳🇿"
        case .oman:                                 return "🇴🇲"
        case .panama:                               return "🇵🇦"
        case .peru:                                 return "🇵🇪"
        case .frenchPolynesia:                      return "🇵🇫"
        case .papuaNewGuinea:                       return "🇵🇬"
        case .philippines:                          return "🇵🇭"
        case .pakistan:                             return "🇵🇰"
        case .poland:                               return "🇵🇱"
        case .saintPierreAndMiquelon:               return "🇵🇲"
        case .pitcairnIslands:                      return "🇵🇳"
        case .puertoRico:                           return "🇵🇷"
        case .palestinianTerritories:               return "🇵🇸"
        case .portugal:                             return "🇵🇹"
        case .palau:                                return "🇵🇼"
        case .paraguay:                             return "🇵🇾"
        case .qatar:                                return "🇶🇦"
        case .reunion:                              return "🇷🇪"
        case .romania:                              return "🇷🇴"
        case .serbia:                               return "🇷🇸"
        case .russia:                               return "🇷🇺"
        case .rwanda:                               return "🇷🇼"
        case .saudiArabia:                          return "🇸🇦"
        case .solomonIslands:                       return "🇸🇧"
        case .seychelles:                           return "🇸🇨"
        case .sudan:                                return "🇸🇩"
        case .sweden:                               return "🇸🇪"
        case .singapore:                            return "🇸🇬"
        case .saintHelena:                          return "🇸🇭"
        case .slovenia:                             return "🇸🇮"
        case .svalbardAndJanMayen:                  return "🇸🇯"
        case .slovakia:                             return "🇸🇰"
        case .sierraLeone:                          return "🇸🇱"
        case .sanMarino:                            return "🇸🇲"
        case .senegal:                              return "🇸🇳"
        case .somalia:                              return "🇸🇴"
        case .suriname:                             return "🇸🇷"
        case .southSudan:                           return "🇸🇸"
        case .saoTomeAndPrincipe:                   return "🇸🇹"
        case .elSalvador:                           return "🇸🇻"
        case .sintMaarten:                          return "🇸🇽"
        case .syria:                                return "🇸🇾"
        case .swaziland:                            return "🇸🇿"
        case .turksAndCaicosIslands:                return "🇹🇨"
        case .chad:                                 return "🇹🇩"
        case .frenchSouthernAndAntarcticLands:      return "🇹🇫"
        case .togo:                                 return "🇹🇬"
        case .thailand:                             return "🇹🇭"
        case .tajikistan:                           return "🇹🇯"
        case .tokelau:                              return "🇹🇰"
        case .timorLeste:                           return "🇹🇱"
        case .turkmenistan:                         return "🇹🇲"
        case .tunisia:                              return "🇹🇳"
        case .tonga:                                return "🇹🇴"
        case .turkey:                               return "🇹🇷"
        case .trinidadAndTobago:                    return "🇹🇹"
        case .tuvalu:                               return "🇹🇻"
        case .taiwan:                               return "🇹🇼"
        case .tanzania:                             return "🇹🇿"
        case .ukraine:                              return "🇺🇦"
        case .uganda:                               return "🇺🇬"
        case .jarvisIsland:                         return "🇺🇲"
        case .bakerIsland:                          return "🇺🇲"
        case .howlandIsland:                        return "🇺🇲"
        case .johnstonAtoll:                        return "🇺🇲"
        case .midwayIslands:                        return "🇺🇲"
        case .wakeIsland:                           return "🇺🇲"
        case .unitedStates:                         return "🇺🇸"
        case .uruguay:                              return "🇺🇾"
        case .uzbekistan:                           return "🇺🇿"
        case .vaticanCity:                          return "🇻🇦"
        case .saintVincentAndTheGrenadines:         return "🇻🇨"
        case .venezuela:                            return "🇻🇪"
        case .britishVirginIslands:                 return "🇻🇬"
        case .usVirginIslands:                      return "🇻🇮"
        case .vietnam:                              return "🇻🇳"
        case .vanuatu:                              return "🇻🇺"
        case .wallisAndFutuna:                      return "🇼🇫"
        case .samoa:                                return "🇼🇸"
        case .yemen:                                return "🇾🇪"
        case .mayotte:                              return "🇾🇹"
        case .southAfrica:                          return "🇿🇦"
        case .zambia:                               return "🇿🇲"
        case .zimbabwe:                             return "🇿🇼"
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
        case .losAngeles:       return .unitedStates
        case .newYork:          return .unitedStates
        case .vancouver:        return .unitedStates
        case .honolulu:         return .unitedStates
        case .sanFrancisco:     return .unitedStates
        case .guam:             return .unitedStates
        case .saipan:           return .unitedStates
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
