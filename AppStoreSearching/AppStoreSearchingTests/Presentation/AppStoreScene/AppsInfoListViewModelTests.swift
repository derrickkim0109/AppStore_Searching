//
//  AppsInfoListViewModelTests.swift
//  AppsInfoListViewModelTests
//
//  Created by Derrick kim on 2023/03/21.
//

//import XCTest
//
//final class AppsInfoListViewModelTests: XCTestCase {
//    private let bag = AnyCancelTaskBag()
//
//    private enum SearchAppsInfoUseCaseError: Error {
//        case someError
//    }
//
//    func test_SearchAppsInfoUseCase때_ViewModel은_데이터를_가지고있다() async {
//        // given
//        let searchAppsInfoUseCaseMock = SearchAppsInfoUseCaseMock()
//        let expectation = self.expectation(
//            description: "DefaultAppsInfoLisViewModel은 앱 리스트 데이터를 가지고 있다.")
//
//        // when
//        searchAppsInfoUseCaseMock.appsInfo = AppInfoEntity.list
//
//        let viewModel = DefaultAppsInfoLisViewModel(
//            searchAppsInfoUseCase: searchAppsInfoUseCaseMock)
//
//        // then
//        Task {
//            await viewModel.didSearch("카카오 뱅크")
//
//            guard let state = viewModel.state else {
//                return
//            }
//
//            switch state {
//            case .success(let data):
//                let ids = data.map { $0.id }
//                XCTAssertEqual(ids[0], 1)
//                expectation.fulfill()
//            case .failed(_):
//                break
//            }
//        }.store(in: bag)
//
//        await waitForExpectations(timeout: 5,
//                                  handler: nil)
//    }
//
//    func test_SearchAppsInfoUseCase가_Error를_반환할_때_ViewModelErrorString을_가지고있다() async {
//        // given
//        let searchAppsInfoUseCaseMock = SearchAppsInfoUseCaseMock()
//        searchAppsInfoUseCaseMock.error = SearchAppsInfoUseCaseError.someError
//
//        let expectation = self.expectation(
//            description: "DefaultAppsInfoLisViewModel은 에러를 가지고 있다.")
//
//        // when
//        let viewModel = DefaultAppsInfoLisViewModel(
//            searchAppsInfoUseCase: searchAppsInfoUseCaseMock)
//
//        // then
//        Task {
//            await viewModel.didSearch("카카오 뱅크")
//
//            guard let state = viewModel.state else {
//                return
//            }
//
//            switch state {
//            case .success(_):
//                break
//            case .failed(let error):
//                XCTAssertFalse(error.isEmpty)
//                expectation.fulfill()
//            }
//        }.store(in: bag)
//
//        await waitForExpectations(timeout: 5,
//                                  handler: nil)
//    }
//}
