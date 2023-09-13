# App Store Searching
> 프로젝트 기간 2023.03.18 ~ 2023.03.22    
개발자 : [derrick](https://github.com/derrickkim0109) 

# 📋 목차
- [🔎 프로젝트 소개](#-프로젝트-소개)
- [📺 프로젝트 실행화면](#-프로젝트-실행화면)
- [🗂 App 구조](#-app-구조)

## 🔎 프로젝트 소개
> 해당 프로젝트는 App Store의 Seaching 뷰를 구현한 것입니다. 기존 코드를 리팩트링하여 각 layer 별 분리, 의존성 최소화를 목표로 구현하였습니다.
---

## 📺 프로젝트 실행화면

|메인화면|검색중|검색결과|
|--|--|--|
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/e9ce7bfa-90a1-4432-a5e0-737ccfc7474a" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/8f3ed0cf-5bed-4fff-842e-38fc4422bacf" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/f471cfbd-b667-4871-a78b-37a99b327e9c" width="250">|

|Pagenation|상세화면|받기버튼|
|--|--|--|
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/33f3a668-61ae-43e9-8ef0-b5039d7c03f2" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/ad66d20b-bd2e-48c1-aeb1-017c04024cd5" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/3e643e26-4f83-4b84-9218-9692b5d5e980" width="250">|


---

## 🗂 App 구조

### 기술스택

- UIKit
- async/await
- Combine
- Unit Test

### Layers

- **Domain Layer** = Entities + Use Cases + Repositories Interfaces
- **Data Repositories Layer** = Repositories Implementations + API (Network)
- **Presentation Layer (MVVM)** = ViewModels + Views

### Dependency Direction

<img src="https://i.imgur.com/O7ISX8z.png" width="600">

- Domain Layer에 다른 레이어(예: Presentation — UIKit, Data Layer — Mapping Codable)가 포함되지 않도록 처리하였습니다. 
- Presentation Layer에 Domain Entity를 맵핑하기 위한 Mapper 타입, Model 타입을 구현하여 Domain인과의 의존성을 최소화 시켰습니다.

### MVVM, CleanArchitecture

- 
