//
//  NetworkServiceTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class NetworkServiceTests: XCTestCase {
    private struct MockModel: Decodable {
        let name: String
    }

    var mockNetworkService: MockNetworkService!

    override func setUpWithError() throws {
        super.setUp()

        mockNetworkService = MockNetworkService()
    }

    override func tearDownWithError() throws {
        super.tearDown()

        mockNetworkService = nil
    }
    
    func test_유효한JSONResponse를받았을때_디코딩_가능한_객체에_대한Response를디코딩해야한다() async {
        //given
        let expectation = self.expectation(
            description: "Mock Object를 디코드한다.")

        // when
        do {
            let endpoint = Endpoint<AppSearchResponseDTO>(path: "/search", httpMethod: .get)
            let data = try await mockNetworkService.request(endpoint: endpoint)

            XCTAssertTrue(type(of: data) == AppSearchResponseDTO.self)
            expectation.fulfill()
        } catch {
            XCTFail("정확한 데이터가 반환되어야 한다.")
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_유효하지않은ResponseDTO일때_객체를Decode되지_않는다() async {
        //given
        let expectation = self.expectation(
            description: "Mock Object를 디코드 하지 않아야한다.")

        mockNetworkService.scenario = .failure

        //when
        do {
            let endpoint = Endpoint<MockModel>(path: "/search", httpMethod: .get)
            let _ = try await mockNetworkService.request(endpoint: endpoint)
        } catch {
            XCTAssertTrue(error is NetworkError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }
}
