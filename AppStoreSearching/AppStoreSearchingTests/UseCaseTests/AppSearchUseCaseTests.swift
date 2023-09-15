//
//  AppSearchUseCaseTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchUseCaseTests: XCTestCase {
    var usecase: MockAppSearchUseCase!

    override func setUpWithError() throws {
        super.setUp()

        usecase = MockAppSearchUseCase()
    }

    override func tearDownWithError() throws {
        super.tearDown()

        usecase = nil
    }

    func test_앱_검색에_성공하다() async {
        // given
        let expectation = XCTestExpectation(description: "앱 검색 성공")
        let keyword = "카카오 뱅크"
        let page = 0
        let size = 10

        // when
        do {
            let appSearchEntity = try await usecase.searchApp(by: keyword, page: page, size: size)
            XCTAssertTrue(type(of: appSearchEntity) == AppSearchEntity.self)
            expectation.fulfill()
        } catch {
            XCTFail()
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_정규식을_통과하지_못하는_keyword인_경우_invalidKeywordError를_반환한다() async {
        // given
        let expectation = XCTestExpectation(description: "유효하지 않은 키워드로인한 검색 실패")
        let keyword = "kakao"
        let page = 0
        let size = 10

        usecase.scenario = .failure

        // when
        do {
            let _ = try await usecase.searchApp(by: keyword, page: page, size: size)
        } catch {
            XCTAssertEqual(error as! AppSearchError, .invalidKeyword)
            expectation.fulfill()
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_검색에_실패한_경우_failToSearchApp를_반환한다() async {
        // given
        let expectation = XCTestExpectation(description: "검색에_실패한_경우_failToSearchApp")
        let keyword = "헤이"
        let page = 0
        let size = 10

        usecase.scenario = .failure

        // when
        do {
            let _ = try await usecase.searchApp(by: keyword, page: page, size: size)
        } catch {
            XCTAssertEqual(error as! AppSearchError, .failToSearchApp)
            expectation.fulfill()
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }
}
