//
//  SearchAppsInfoUseCaseTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/03/22.
//

//import XCTest
//
//final class SearchAppsInfoUseCaseTests: XCTestCase {
//    let appsInfo: [AppInfoEntity] = AppInfoEntity.list
//
//    enum AppsInfoRepositorySuccessTestError: Error {
//        case failedSearching
//    }
//
//    func testSearchAppsInfoUseCase_앱_이름을_검색하여_리스트연결이성공할_때() async {
//        // given
//        let expectation = self.expectation(description: "앱 이름을 검색하여 리스트를 출력한다.")
//
//        let appsInfoRepositoryMock = AppsInfoRepositoryMock(
//            result: appsInfo,
//            error: nil)
//
//        let useCase = DefaultSearchAppsInfoUseCase(
//            appsInfoRepository: appsInfoRepositoryMock)
//
//        // when
//        let requestValue = SearchAppsInfoUseCaseRequestValue(
//            term: "카카오",
//            country: "kr",
//            limit: 10)
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
//    func testSearchAppsInfoUseCase_앱_이름을_검색하여_리스트연결이실패할_때() async {
//        // given
//        let expectation = self.expectation(description: "앱 이름을 검색하여 리스트를 출력에 실패한다.")
//        let error = AppsInfoRepositorySuccessTestError.failedSearching
//
//        let appsInfoRepositoryMock = AppsInfoRepositoryMock(
//            result: appsInfo,
//            error: error)
//
//        let useCase = DefaultSearchAppsInfoUseCase(
//            appsInfoRepository: appsInfoRepositoryMock)
//
//        // when
//        let requestValue = SearchAppsInfoUseCaseRequestValue(
//            term: "카카오",
//            country: "kr",
//            limit: 10)
//
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
