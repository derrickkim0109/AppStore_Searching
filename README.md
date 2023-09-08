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

|메인화면|최근검색어|검색중|
|--|--|--|
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/8e48d880-e85b-4ef0-92c5-a146e29c0f7d" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/5e3bfd4f-9568-401c-8f42-a04f552420b3" width="250">|<<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/f425db0f-ace4-4fed-8245-a8342352057d" width="250">|

|검색결과|Pagenation|받기버튼|
|--|--|--|
|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/963e98bc-7cf9-42fe-8347-73d5632b15fd" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/27163b48-d701-4f5f-b18e-be4feb96c317" width="250">|<img src="https://github.com/derrickkim0109/AppStore_Searching/assets/59466342/8bcacf73-1158-40ce-9a4b-ccfd3ee50052" width="250">|



---

## 🗂 App 구조

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
