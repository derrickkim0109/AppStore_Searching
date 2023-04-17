//
//  FetchAppInfoUseCaseTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

//import XCTest
//
//final class FetchAppInfoUseCaseTests: XCTestCase {
//    let appsInfo: [AppInfoEntity] = AppInfoEntity.list
//
//    enum AppInfoRepositorySuccessTestError: Error {
//        case failedFetching
//    }
//
//    func testFetchAppInfoUseCase_앱정보출력을성공할_때() async {
//        // given
//        let expectation = self.expectation(description: "앱 정보를 출력한다.")
//
//        let appInfoRepositoryMock = AppInfoRepositoryMock(
//            result: appsInfo,
//            error: nil)
//
//        let id = appInfoRepositoryMock.result.first?.id ?? 0
//
//        let useCase = DefaultFetchAppInfoUseCase(
//            appInfoRepository: appInfoRepositoryMock)
//
//        // when
//        let requestValue = FetchAppInfoUseCaseRequestValue(
//            id: id,
//            country: "kr")
//
//        // then
//        var responsedAppsInfo: [AppInfoEntity] = []
//
//        do {
//            let data = try await useCase.execute(requestValue: requestValue)
//
//            responsedAppsInfo = data
//
//            expectation.fulfill()
//        } catch { }
//
//        await waitForExpectations(
//            timeout: 5,
//            handler: nil)
//
//        XCTAssertEqual(
//            responsedAppsInfo[0].id,
//            appsInfo[0].id)
//    }
//
//    func testFetchAppInfoUseCase_앱_정보출력에실패할_때() async {
//        // given
//        let expectation = self.expectation(description: "앱 정보 출력에 실패한다.")
//        let error = AppInfoRepositorySuccessTestError.failedFetching
//
//        let appInfoRepositoryMock = AppInfoRepositoryMock(
//            result: appsInfo,
//            error: error)
//
//        let id = appInfoRepositoryMock.result.first?.id ?? 0
//
//        let useCase = DefaultFetchAppInfoUseCase(
//            appInfoRepository: appInfoRepositoryMock)
//
//        // when
//        let requestValue = FetchAppInfoUseCaseRequestValue(
//            id: id,
//            country: "kr")
//        // then
//        var responsedAppsInfo: [AppInfoEntity] = []
//
//        do {
//            let data = try await useCase.execute(requestValue: requestValue)
//            responsedAppsInfo = data
//        } catch {
//            expectation.fulfill()
//        }
//
//        await waitForExpectations(
//            timeout: 5,
//            handler: nil)
//
//        XCTAssertTrue(responsedAppsInfo.isEmpty)
//    }
//}
//
