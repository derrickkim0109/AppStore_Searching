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
        let expectation = AppSearchEntityObjectMother.getAppSearchEntityWithCompleteData()

        // when
        let entity = completeDataDTO.toEntity()

        // then
        XCTAssertEqual(expectation.resultCount, entity.resultCount)
        XCTAssertEqual(expectation.results.first?.artistId, entity.results.first?.artistId)
    }

    func test_DTO_데이터가_nil값으로_들어올_경우_Default값이_Entity로_변환한다() {
        // given
        let expectation = AppSearchEntityObjectMother.getAppSearchEntityWithInsufficientData()

        // when
        let entity = insufficientDataDTO.toEntity()

        // then
        XCTAssertEqual(expectation.resultCount, entity.resultCount)
        XCTAssertEqual(expectation.results.first?.artistId, entity.results.first?.artistId)
    }
}
