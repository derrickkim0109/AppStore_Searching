//
//  NetworkServiceTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

//import XCTest
//
//@testable import AppStoreSearching
//
//final class NetworkServiceTests: XCTestCase {
//    func test_Mock데이터를받을때_정확한Response가반환되어야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//
//        let expectation = self.expectation(
//            description: "정확한 데이터가 반환되어야 한다.")
//
//        let baseURL = NetworkConfigurableMock().baseURL
//        let path = HTTPPath.lookup.value
//
//        let expectedResponseData = "Response data".data(
//            using: .utf8)!
//
//        let response = HTTPURLResponse(
//            url: baseURL,
//            statusCode: 200,
//            httpVersion: "1.1",
//            headerFields: [:])
//
//        let sut = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: response,
//                                                      data: expectedResponseData,
//                                                      error: nil))
//        //when
//        do {
//            let responseData = try await sut.request(
//                endpoint: EndpointMock(path: path,
//                                       method: .get))
//
//            XCTAssertEqual(responseData,
//                           expectedResponseData)
//
//            expectation.fulfill()
//        } catch {
//            XCTFail("정확한 데이터가 반환되어야 한다.")
//        }
//        //then
//        wait(
//            for: [expectation],
//            timeout: 0.1)
//    }
//
//    func test_Error가_NSURLErrorCancelled로_반환될때_CancelledError를반환해야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "hasStatusCode error가 반환되어야 한다.")
//
//        let cancelledError = NSError(
//            domain: "network",
//            code: NSURLErrorCancelled, userInfo: nil) as Error
//
//        let sut = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: nil,
//                                                      data: nil,
//                                                      error: cancelledError))
//        //when
//        do {
//            _ = try await sut.request(
//                endpoint: EndpointMock(path: path,
//                                       method: .get))
//
//            XCTFail("발생하면 안된다.")
//        } catch let error {
//            guard case NetworkError.cancelled = error else {
//                XCTFail("NetworkError.cancelled 찾을수 없다.")
//                return
//            }
//
//            expectation.fulfill()
//        }
//
//        //then
//        wait(
//            for: [expectation],
//            timeout: 0.1)
//    }
//
//    func test_StatusCode가_400이상일때_error를_반환해야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Should return hasStatusCode error")
//
//        let response = HTTPURLResponse(
//            url: URL(string: "test_url")!,
//            statusCode: 500,
//            httpVersion: "1.1",
//            headerFields: [:])
//
//        let sut = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: response,
//                                                      data: nil,
//                                                      error: NetworkErrorMock.someError))
//
//        //when
//        do {
//            _ = try await sut.request(
//                endpoint: EndpointMock(path: path,
//                                       method: .get))
//
//            XCTFail("발생하면 안된다.")
//        } catch let error {
//            if case NetworkError.error(let statusCode, _) = error {
//                XCTAssertEqual(statusCode,
//                               500)
//
//                expectation.fulfill()
//            }
//        }
//
//        //then
//        wait(
//            for: [expectation],
//            timeout: 0.1)
//    }
//
//    func test_Error가_NSURLErrorNotConnectedToInternet일때_NotConnectedError가반환되어야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Should return hasStatusCode error")
//
//        let error = NSError(
//            domain: "network",
//            code: NSURLErrorNotConnectedToInternet, userInfo: nil)
//
//        let sut = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: nil,
//                                                      data: nil,
//                                                      error: error as Error))
//        //when
//        do {
//            _ = try await sut.request(
//                endpoint: EndpointMock(path: path,
//                                       method: .get))
//
//            XCTFail("발생하면 안된다.")
//        } catch let error {
//            guard case NetworkError.notConnected = error else {
//                XCTFail("NetworkError.notConnected not found")
//                return
//            }
//            expectation.fulfill()
//        }
//
//        //then
//        wait(
//            for: [expectation],
//            timeout: 0.1)
//    }
//
//    func test_hasStatusCode가에러에사용될때_False를반환해야한다() {
//        //when
//        let sut = NetworkError.notConnected
//        //then
//        XCTAssertFalse(sut.hasStatusCode(200))
//    }
//
//    func test_hasStatusCode를사용할때_정확한StatusCode를반환해야한다() {
//        //when
//        let sut = NetworkError.error(
//            statusCode: 400,
//            data: nil)
//        //then
//        XCTAssertTrue(sut.hasStatusCode(400))
//        XCTAssertFalse(sut.hasStatusCode(399))
//        XCTAssertFalse(sut.hasStatusCode(401))
//    }
//}
//
//fileprivate struct EndpointMock: Requestable {
//    var path: String
//    var isFullPath: Bool = false
//    var method: HTTPMethod
//    var headerParameters: [String: String] = [:]
//    var queryParametersEncodable: Encodable?
//    var queryParameters: [String: Any] = [:]
//    var bodyParametersEncodable: Encodable?
//    var bodyParameters: [String: Any] = [:]
//    var bodyEncoding: BodyEncoding = .stringEncodingAscii
//
//    init(
//        path: String,
//        method: HTTPMethod) {
//            self.path = path
//            self.method = method
//        }
//}
//
//fileprivate enum NetworkErrorMock: Error {
//    case someError
//}
//
