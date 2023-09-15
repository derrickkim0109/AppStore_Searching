//
//  AppSearchRepositoryTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchRepositoryTests: XCTestCase {
    var mockAppSearchDataSource: MockAppSearchDataSource!
    var repository: AppSearchRepositoryInterface!

    private let bag = AnyCancelTaskBag()

    override func setUpWithError() throws {
        super.setUp()

        mockAppSearchDataSource = MockAppSearchDataSource()
        repository = AppSearchRepository(dataSource: mockAppSearchDataSource)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        repository = nil
        mockAppSearchDataSource = nil
    }

    func test_앱_검색을_성공한다() async {
        // given
        let expectation = XCTestExpectation(description: "앱 검색 성공")
        let keyword = "카카오 뱅크"
        let page = 0
        let size = 10

        mockAppSearchDataSource.scenario = .success

        // when
        do {
            let _ = try await repository.searchApp(by: keyword, page: page, size: size)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_UnknownError로_인해_앱_검색에_실패한다() async {
        // given
        let expectation = XCTestExpectation(description: "UnknownError로 인한 API 실패")
        let keyword = "카카오 뱅크"
        let page = 0
        let size = 10

        mockAppSearchDataSource.scenario = .failure

        // when
        do {
            let _ = try await repository.searchApp(by: keyword, page: page, size: size)
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! NetworkError, NetworkError.unknownError)
            expectation.fulfill()
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_BadRequestError로_인해_API호출이_실패한다() async {
        // given
        let expectation = XCTestExpectation(description: "Bad Request로 인한 API 실패")
        let keyword = "카카오 뱅크"
        let page = 0
        let size = 10

        mockAppSearchDataSource.scenario = .failure
        mockAppSearchDataSource.networkError = NetworkError.badRequestError

        // when
        do {
            let _ = try await repository.searchApp(by: keyword, page: page, size: size)
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! NetworkError, NetworkError.badRequestError)
            expectation.fulfill()
        }

        // then
        await fulfillment(of: [expectation], timeout: 5)
    }
}
