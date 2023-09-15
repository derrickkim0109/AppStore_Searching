//
//  AppSearchItemDTOTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchItemDTOTests: XCTestCase {
    var completeDataDTO: AppSearchItemResponseDTO!
    var insufficientDataDTO: AppSearchItemResponseDTO!

    override func setUpWithError() throws {
        super.setUp()

        completeDataDTO = AppSearchDTOObjectMother.getCompletedAppSearchItemResponseDTO()
        insufficientDataDTO = AppSearchDTOObjectMother.getInsufficientAppSearchItemResponseDTO()
    }

    override func tearDownWithError() throws {
        super.tearDown()

        completeDataDTO = nil
        insufficientDataDTO = nil
    }

    func test_DTO의_모든_데이터가_성공적으로_Entity로_변환한다() {
        // given
        let expectation = AppSearchEntityObjectMother.getCompletedAppSearchItemEntity()

        // when
        let entity = completeDataDTO.toEntity()

        // then
        XCTAssertTrue(type(of: entity) == AppSearchItemEntity.self)
        XCTAssertEqual(expectation.trackName, entity.trackName)
        XCTAssertEqual(expectation.minimumOsVersion, entity.minimumOsVersion)
        XCTAssertEqual(expectation.genres.first, entity.genres.first)
    }

    func test_DTO_데이터가_nil값으로_들어올_경우_Default값이_Entity로_변환한다() {
        // given
        let expectation = AppSearchEntityObjectMother.getInsufficientAppSearchItemEntity()

        // when
        let entity = insufficientDataDTO.toEntity()

        // then
        XCTAssertEqual(expectation.languages, entity.languages)
        XCTAssertEqual(expectation.releaseNotes, entity.releaseNotes)
        XCTAssertEqual(expectation.description, entity.description)
        XCTAssertEqual(expectation.screenshotUrls, entity.screenshotUrls)
        XCTAssertEqual(expectation.artworkUrl512, entity.artworkUrl512)
    }

    func test_languageCodesISO2A_데이터가_KO을_포함하면_해당_값이_Languages배열_첫_번째_값이다() {
        // given
        let expectation = AppLanguageCodeEntity.KO

        // when
        let entity = completeDataDTO.toAppStoreLanguageCodeEntity()

        // then
        XCTAssertEqual(expectation, entity?.first)
    }

    func test_languageCodesISO2A_데이터가_EN을_포함하고_KO가_없으면_EN이_Languages배열_첫_번째_값이다() {
        // given
        let expectation = AppLanguageCodeEntity.EN

        // when
        completeDataDTO = AppSearchDTOObjectMother.getAppSearchItemResponseDTO([
            "NL", "PT", "DA", "FI", "NO", "JA", "EN", "ZH"
        ])

        let entity = completeDataDTO.toAppStoreLanguageCodeEntity()

        // then
        XCTAssertEqual(expectation, entity?.first)
    }
    
    func test_languageCodesISO2A_데이터가_KO와_EN을_포함_하면_Languages배열_첫_번째는_KO_두_번째는_EN이다() {
        // given
        let expectation = [
            AppLanguageCodeEntity.KO,
            AppLanguageCodeEntity.EN
        ]

        // when
        let entity = completeDataDTO.toAppStoreLanguageCodeEntity()

        // then
        XCTAssertEqual(expectation[0], entity?[0])
        XCTAssertEqual(expectation[1], entity?[1])
    }

    func test_languageCodesISO2A_데이터가_KO와_EN을_포함_하지않으면_Languages배열_그대로_출력된다() {
        // given
        let expectation = [
            AppLanguageCodeEntity.NL,
            AppLanguageCodeEntity.PT,
            AppLanguageCodeEntity.DA,
            AppLanguageCodeEntity.FI,
            AppLanguageCodeEntity.NO,
        ]

        // when
        completeDataDTO = AppSearchDTOObjectMother.getAppSearchItemResponseDTO([
            "NL", "PT", "DA", "FI", "NO"
        ])

        let languageCodeEntity = completeDataDTO.toAppStoreLanguageCodeEntity()

        // then
        XCTAssertEqual(expectation, languageCodeEntity)
    }

    func test_supportedDevices로_들어오는_데이터들이_지원하는_디바이스_일때_True_이다() {
        // given
        let expectation = true

        // when
        let isCompatiable = completeDataDTO.isCompatibleToDevice(deviceModel: "iPhone 14 Plus")

        // then
        XCTAssertEqual(expectation, isCompatiable)
    }

    func test_supportedDevices로_들어오는_데이터들이_지원하지않는_디바이스_일때_False_이다() {
        // given
        let expectation = false

        // when
        let isCompatiable = completeDataDTO.isCompatibleToDevice(deviceModel: "iPhone 14 Pro")

        // then
        XCTAssertEqual(expectation, isCompatiable)
    }
}
