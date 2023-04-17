//
//  AppInfoEntity+Stub.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

extension AppInfoEntity {
    static func stub(
        id: Int,
        name: String,
        icon: String,
        genres: [String],
        artistName: String,
        averageUserRating: Double,
        userRatingCount: Int,
        screenshots: [String],
        description: String) -> Self {
            return AppInfoEntity(
                id: id,
                name: name,
                icon: icon,
                genre: genres.first,
                artistName: artistName,
                averageUserRating: averageUserRating,
                userRatingCount: userRatingCount,
                screenshots: screenshots,
                description: description)

        }

    static let list = [
        AppInfoEntity(
            id: 1,
            name: "카카오뱅크",
            icon: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/cc/84/de/cc84debb-ed63-33a9-36ee-6be18ad1cfb0/AppIcon_real-1x_U007emarketing-0-7-0-85-220.png/512x512bb.jpg",
            genre: "금융",
            artistName: "Kakao Corp.",
            averageUserRating: 1258016944,
            userRatingCount: 11264,
            screenshots: [
                "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/5e/23/ce/5e23ceb6-5dae-feaf-7935-db3521241da2/18fb42d3-feac-4a2b-a556-53f14a1dd2a8_ios_5.5_01.png/392x696bb.png",
                "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/c2/79/0e/c2790e81-5d52-c9d8-4269-ccb6657aaad7/770eb254-8706-4960-ae0a-dadc98d05b49_ios_5.5_02.png/392x696bb.png",
                "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/7c/df/a8/7cdfa814-b6c2-7765-f5ee-9eab90437c8e/5d99d40c-a06a-44e8-ad4f-74522aa54602_ios_5.5_03.png/392x696bb.png",
                "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource123/v4/79/58/64/7958645b-dd1a-313f-da38-c57e3065626d/c0b00dfc-af13-48f2-87ba-f90f16fc6708_ios_5.5_04.png/392x696bb.png",
                "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource123/v4/8d/55/31/8d55314c-bfe0-d9f3-9dfd-20fe01587a61/a796974a-d685-4e41-a513-51632c525618_ios_5.5_05.png/392x696bb.png",
                "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource123/v4/9c/73/cb/9c73cb92-2a9d-7010-d4b0-438551ff6f3d/9f7d7eb0-1bbe-424a-9b41-6e6f86c60c82_ios_5.5_06.png/392x696bb.png",
                "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/23/6e/3c/236e3c9c-a676-24f5-dd2b-b4ea9897fe62/3d8fe1de-df8d-439c-bdd3-9a7ff44558d0_ios_5.5_07.png/392x696bb.png",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource123/v4/9a/c7/f4/9ac7f4a4-bafe-ce1d-34a1-5bfb14d6211f/4a28a243-a079-44db-84e5-b91e0494b482_ios_5.5_08.png/392x696bb.png"],
            description: "앱설명")
    ]
}
