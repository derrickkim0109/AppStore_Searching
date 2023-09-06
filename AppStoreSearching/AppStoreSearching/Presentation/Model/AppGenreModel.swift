//
//  AppGenreModel.swift
//  AppStoreSearching
//
//  Created by Derrick kim on 2023/09/06.
//

enum AppGenreModel: String {
    case games = "게임"
    case action = "액션"
    case adventure = "어드벤처"
    case casual = "캐주얼"
    case board = "보드"
    case card = "카드"
    case casino = "카지노"
    case dice = "주사위"
    case family = "가족"
    case racing = "레이싱"
    case rolePlaying = "롤플레잉"
    case strategy = "전략"
    case trivia = "퀴즈"
    case word = "단어"
    case simulation = "시뮬레이션"
    case entertainment = "엔터테인먼트"
    case sports = "스포츠"
    case productivity = "생산성"
    case music = "음악", utilities = "유틸리티"
    case education = "교육"
    case graphicsDesign = "그래픽 & 디자인"
    case photoVideo = "사진 및 비디오"
    case socailNetworking = "소셜 네트워킹"
    case puzzle = "퍼즐"
    case travel = "여행"
    case finance = "금융"
    case navigation = "내비게이션"
    case lifestyle = "라이프 스타일"
    case business = "비즈니스"
    case reference = "레퍼런스"
    case overall = "전체"
    case weather = "날씨"
    case news = "뉴스"
    case healthFitness = "건강 및 피트니스"
    case books = "도서"
    case medical = "의료"
    case magazinesNewspapers = "잡지 및 신문"
    case catalogs = "카타로그"
    case foodDrink = "음식 및 음료"
    case shopping = "쇼핑"
    case stickers = "스티커"
    case developerTools = "개발자 도구"
}

extension AppGenreModel {
    var id: Self {
        self
    }

    var imageName: String {
        switch self {
        case .games:                 return "gamecontroller.fill"
        case .action:                return "bolt.fill"
        case .adventure:             return "binoculars.fill"
        case .casual:                return "gamecontroller.fill"
        case .board:                 return "cube.box.fill"
        case .card:                  return "rectangle.stack.fill"
        case .casino:                return "die.face.6.fill"
        case .dice:                  return "die.face.6.fill"
        case .family:                return "person.3.fill"
        case .racing:                return "flag.checkered"
        case .rolePlaying:           return "die.face.6.fill"
        case .strategy:              return "die.face.6.fill"
        case .trivia:                return "die.face.6.fill"
        case .word:                  return "die.face.6.fill"
        case .simulation:            return "die.face.6.fill"
        case .entertainment:         return "tv.music.note.fill"
        case .sports:                return "sportscourt.fill"
        case .productivity:          return "die.face.6.fill"
        case .music:                 return "music.note"
        case .utilities:             return "die.face.6.fill"
        case .education:             return "die.face.6.fill"
        case .graphicsDesign:        return "die.face.6.fill"
        case .photoVideo:            return "photo.on.rectangle.fill"
        case .socailNetworking:      return "person.2.fill"
        case .puzzle:                return "puzzlepiece.fill"
        case .travel:                return "airplane.circle.fill"
        case .finance:               return "die.face.6.fill"
        case .navigation:            return "die.face.6.fill"
        case .lifestyle:             return "die.face.6.fill"
        case .business:              return "die.face.6.fill"
        case .reference:             return "die.face.6.fill"
        case .overall:               return "die.face.6.fill"
        case .weather:               return "die.face.6.fill"
        case .news:                  return "newspaper.fill"
        case .healthFitness:         return "heart.circle.fill"
        case .books:                 return "die.face.6.fill"
        case .medical:               return "die.face.6.fill"
        case .magazinesNewspapers:   return "die.face.6.fill"
        case .catalogs:              return "die.face.6.fill"
        case .foodDrink:             return "die.face.6.fill"
        case .shopping:              return "bag.fill"
        case .stickers:              return "die.face.6.fill"
        case .developerTools:        return "die.face.6.fill"
        }
    }
}