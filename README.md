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
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/4e6334d5-6a3f-4808-8d8f-9dac56513a1e" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/0c24830f-d14d-484e-90f5-c15e382b4c10" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/426e720a-f9b9-46c2-97c3-fee93a20c4b8" width="250">|

|Pagenation|상세화면|받기버튼|
|--|--|--|
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/5fd0713f-24ff-43b0-8825-82626d7bb5f4" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/67812b63-72c2-446b-b7a7-fe6d32a6f1c2" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/d5027fc3-0a49-4647-aee2-a172290d7e3d" width="250">|

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

- 클린 아키텍처의 핵심 개념인 의존성 역전 원칙과 인터페이스를 활용하여 각 레이어를 분리하고, 각 레이어 사이의 의존성을 최소화했습니다. MVVM은 뷰, 뷰 모델, 모델로 구성되어 있으며, 각 역할에 따라 책임을 명확하게 분리하였습니다.
이러한 클린 아키텍처와 MVVM의 조합을 통해 프로젝트는 유지 보수성과 확장성을 높이며, 테스트 용이성을 제공합니다. 또한, 코드의 가독성과 재사용성을 향상시키고, 애플리케이션의 비즈니스 로직과 UI를 분리하여 개발 과정을 단순화했습니다. 
