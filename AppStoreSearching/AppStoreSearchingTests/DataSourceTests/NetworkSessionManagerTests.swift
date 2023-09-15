//
//  NetworkSessionManagerTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class NetworkSessionManagerTests: XCTestCase {
    var mockNetworkSessionManager: NetworkSessionManagerInterface!

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()

        mockNetworkSessionManager = nil
    }

    func test_response가_nil일_때_invalidResponseError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "invalidResponseError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: nil,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("invalidResponseError가 반환되어야 한다.")
            
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponseError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response_200_Mock데이터를받을때_정확한_Response_Data가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "정확한 데이터가 반환되어야 한다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)
        let expectedResponseData = "Response data".data(
            using: .utf8
        )!

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 200,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: expectedResponseData
        )

        //when
        do {
            let responseData = try await mockNetworkSessionManager.request(urlRequest)
            XCTAssertEqual(responseData, expectedResponseData)

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

    func test_response가_400일_때_badRequestError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "badRequestError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 400,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("badRequestError가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.badRequestError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_401일_때_unauthorizedError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "unauthorizedError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 401,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("unauthorizedError가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.unauthorizedError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_403일_때_forbiddenError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "forbiddenError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 403,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("forbiddenError가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.forbiddenError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_404일_때_notFoundError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "notFoundError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 404,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("notFoundError가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.notFoundError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_500일_때_serverError가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "serverError가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 500,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("serverError가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.serverError)
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_402_혹은_405에서_499_사이_일_때_error4xx_response_statusCode_가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "error4xx(response.statusCode)가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 489,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("error4xx(response.statusCode)가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.error4xx(response!.statusCode))
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }

    func test_response가_501에서_599_사이_일_때_error5xx_response_statusCode_가_반환되어야한다() async throws {
        //given
        let expectation = self.expectation(
            description: "error5xx(response.statusCode)가 반환된다.")
        let baseURL = URL(string: "https://itunes.apple.com")!
        let urlRequest = URLRequest(url: baseURL)

        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 549,
            httpVersion: "1.1",
            headerFields: [:])

        mockNetworkSessionManager = NetworkSessionManagerMock(
            response: response,
            data: nil
        )

        //when
        do {
            let _ = try await mockNetworkSessionManager.request(urlRequest)
            XCTFail("error5xx(response.statusCode)가 반환되어야 한다.")

        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.error5xx(response!.statusCode))
            expectation.fulfill()
        }

        //then
        await fulfillment(
            of: [expectation],
            timeout: 0.1
        )
    }
}
