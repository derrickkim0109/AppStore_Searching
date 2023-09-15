//
//  AppSearchDataSourceTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchDataSourceTests: XCTestCase {
    var datasource: AppSearchDataSourceInterface!
    var mockNetworkService: MockNetworkService!

    override func setUpWithError() throws {
        super.setUp()

        mockNetworkService = MockNetworkService()
        datasource = AppSearchDataSource(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        super.tearDown()

        datasource = nil
        mockNetworkService = nil
    }

    //MARK: 앱 검색에 성공한다.
    func test_앱_검색에_성공한다() async {
        // given
        let expectation = XCTestExpectation(description: "앱 검색 성공")
        let requestDTO = AppSearchRequestDTO(keyword: "카카오 뱅크",
                                             media: "software",
                                             country: "kr",
                                             page: 0,
                                             size: 10)
        // when
        do {
            let _ = try await datasource.searchAppByKeyword(requestDTO)
            expectation.fulfill()
        } catch {
            XCTFail()
        }

        // then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_ServerError로_앱_검색에_실패하다() async {
        // given
        let expectation = XCTestExpectation(description: "ServerError로 인한 API 실패")
        let requestDTO = AppSearchRequestDTO(keyword: "카카오 뱅크",
                                             media: "software",
                                             country: "kr",
                                             page: 0,
                                             size: 10)
        mockNetworkService.scenario = .failure
        mockNetworkService.networkError = .serverError

        // when
        do {
            let _ = try await datasource.searchAppByKeyword(requestDTO)
        } catch {
            XCTAssertEqual(error as! NetworkError, .serverError)
            expectation.fulfill()
        }

        // then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }
}
