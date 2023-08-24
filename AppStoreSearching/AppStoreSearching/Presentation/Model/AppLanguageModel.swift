//
//  AppLanguageModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/08/22.
//

enum AppLanguageModel: String {
    case EN, ES, FR, DE, IT, JA, KO, NL,
         PT, RU, ZH, SV, NO, DA, FI, TR,
         EL, CS, PL, HU, SK, HR, RO, TH, VI
}

extension AppLanguageModel {
    var id: Self {
        self
    }

    func getLanguageValue() -> String {
        switch self {
        case .EN: return "영어"
        case .ES: return "스페인어"
        case .FR: return "프랑스어"
        case .DE: return "독일어"
        case .IT: return "이탈리아어"
        case .JA: return "일본어"
        case .KO: return "한국어"
        case .NL: return "네덜란드어"
        case .PT: return "포르투갈어"
        case .RU: return "러시아어"
        case .ZH: return "중국어"
        case .SV: return "스웨덴어"
        case .NO: return "노르웨이어"
        case .DA: return "덴마크어"
        case .FI: return "핀란드어"
        case .TR: return "터키어"
        case .EL: return "그리스어"
        case .CS: return "체코어"
        case .PL: return "폴란드어"
        case .HU: return "헝가리어"
        case .SK: return "슬로바키아어"
        case .HR: return "크로아티아어"
        case .RO: return "루마니아어"
        case .TH: return "태국어"
        case .VI: return "베트남어"
        }
    }
}
