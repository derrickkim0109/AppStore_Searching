//
//  AppSearchDTOTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/14.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchDTOTests: XCTestCase {
    var completeDataDTO: AppSearchResponseDTO!
    var insufficientDataDTO: AppSearchResponseDTO!

    override func setUpWithError() throws {
        super.setUp()

        completeDataDTO = AppSearchDTOObjectMother.getAppSearchResponseDTOWithCompleteData()
        insufficientDataDTO = AppSearchDTOObjectMother.getAppSearchResponseDTOWithInsufficientData()
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
        XCTAssertTrue(type(of: entity) == AppSearchEntity.self)
        XCTAssertEqual(expectation.trackName, entity.results.first?.trackName)
        XCTAssertEqual(expectation.minimumOsVersion, entity.results.first?.minimumOsVersion)
        XCTAssertEqual(expectation.genres.first, entity.results.first?.genres.first)
    }

    func test_DTO_데이터가_nil값으로_들어올_경우_Default값이_Entity로_변환한다() {
        // given
        let expectation = AppSearchEntityObjectMother.getInsufficientAppSearchItemEntity()

        // when
        let entity = insufficientDataDTO.toEntity()
        // then
        XCTAssertTrue(type(of: entity) == AppSearchEntity.self)
        XCTAssertEqual(expectation.languages, entity.results.first?.languages)
        XCTAssertEqual(expectation.releaseNotes, entity.results.first?.releaseNotes)
        XCTAssertEqual(expectation.description, entity.results.first?.description)
        XCTAssertEqual(expectation.screenshotUrls, entity.results.first?.screenshotUrls)
        XCTAssertEqual(expectation.artworkUrl512, entity.results.first?.artworkUrl512)
    }
}
