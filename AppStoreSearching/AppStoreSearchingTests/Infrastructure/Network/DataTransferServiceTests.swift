//
//  DataTransferServiceTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//
//
//import XCTest
//
//final class DataTransferServiceTests: XCTestCase {
//    private struct MockModel: Decodable {
//        let name: String
//    }
//
//    private enum DataTransferErrorMock: Error {
//        case someError
//    }
//
//    func test_유효한JSONResponse를받았을때_디코딩가능한객체에대한Response를디코딩해야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Mock Object를 디코드한다.")
//
//        let responseData = #"{"name": "Hello"}"#.data(
//            using: .utf8)
//
//        let networkService = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: nil,
//                                                      data: responseData,
//                                                      error: nil))
//
//        let sut: DataTransferService = DefaultDataTransferService(
//            with: networkService)
//
//        //when
//        do {
//            let endpoint = Endpoint<MockModel>(
//                path: path,
//                method: .get)
//
//            let responseData = try await sut.request(
//                with: endpoint)
//
//            XCTAssertEqual(responseData.name,
//                           "Hello")
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
//    func test_유효하지않은Response일때_객체를Decode하지않아야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Mock Object를 디코드 하지 않아야한다.")
//
//
//        let responseData = #"{"age": 20}"#.data(
//            using: .utf8)
//
//        let networkService = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: nil,
//                                                      data: responseData,
//                                                      error: nil))
//
//        let sut: DataTransferService = DefaultDataTransferService(
//            with: networkService)
//
//        //when
//        do {
//            let endpoint = Endpoint<MockModel>(
//                path: path,
//                method: .get)
//
//            _ = try await sut.request(
//                with: endpoint)
//
//            XCTFail("Should not happen")
//        } catch {
//            expectation.fulfill()
//        }
//        //then
//        wait(
//            for: [expectation],
//            timeout: 0.1)
//    }
//
//
//    func test_BadRequest를받았을때_NetworkError를Throw해야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Should throw network error")
//
//        let responseData = #"{"invalidStructure": "Nothing"}"#.data(
//            using: .utf8)!
//
//        let response = HTTPURLResponse(
//            url: config.baseURL,
//            statusCode: 500,
//            httpVersion: "1.1",
//            headerFields: nil)
//
//        let networkService = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: response,
//                                                      data: responseData,
//                                                      error: DataTransferErrorMock.someError))
//
//        let sut: DataTransferService = DefaultDataTransferService(
//            with: networkService)
//        //when
//        do {
//            let endpoint = Endpoint<MockModel>(
//                path: path,
//                method: .get)
//
//            _ = try await sut.request(
//                with: endpoint)
//
//            XCTFail("Should not happen")
//        } catch (let error) {
//            if case DataTransferError.networkFailure(NetworkError.error(statusCode: 500, _)) = error {
//                expectation.fulfill()
//            } else {
//                XCTFail("Wrong error")
//            }
//        }
//
//        //then
//        wait(for: [expectation], timeout: 0.1)
//    }
//
//    func test_받은데이터가없을때_NoDataError를_Throw해야한다() async {
//        //given
//        let config = NetworkConfigurableMock()
//        let path = HTTPPath.lookup.value
//
//        let expectation = self.expectation(
//            description: "Should throw no data error")
//
//        let response = HTTPURLResponse(
//            url: config.baseURL,
//            statusCode: 200,
//            httpVersion: "1.1",
//            headerFields: [:])
//
//        let networkService = DefaultNetworkService(
//            config: config,
//            sessionManager: NetworkSessionManagerMock(response: response,
//                                                      data: nil,
//                                                      error: nil))
//
//        let sut: DataTransferService = DefaultDataTransferService(
//            with: networkService)
//
//        //when
//        do {
//            let endpoint = Endpoint<MockModel>(
//                path: path,
//                method: .get)
//
//            _ = try await sut.request(
//                with: endpoint)
//
//            XCTFail("Should not happen")
//        } catch (let error) {
//            if case DataTransferError.resolvedNetworkFailure(_) = error {
//                expectation.fulfill()
//            } else {
//                XCTFail("Wrong error")
//            }
//        }
//        //then
//        wait(
//            for: [expectation],
//            timeout: 10.1)
//    }
//}
//
