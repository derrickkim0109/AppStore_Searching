//
//  AppDetailViewModelTests.swift
//  AppDetailViewModelTests
//
//  Created by Derrick kim on 2023/03/22.
//

//import XCTest
//
//final class AppDetailViewModelTests: XCTestCase {
//    private let bag = AnyCancelTaskBag()
//
//    private enum FetchAppInfoUseError: Error {
//        case someError
//    }
//
//    func test_FetchAppInfoUse때_ViewModel은_데이터를_가지고있다() async {
//        // given
//        let fetchAppInfoUseCaseMock = FetchAppInfoUseCaseMock()
//        let expectation = self.expectation(
//            description: "DefaultAppDetailViewModel은 앱 데이터를 가지고 있다.")
//
//        // when
//        fetchAppInfoUseCaseMock.appsInfo = AppInfoEntity.list
//
//        let viewModel = DefaultAppDetailViewModel(
//            appId: 1,
//            fetchAppInfoUseCase: fetchAppInfoUseCaseMock)
//
//        // then
//        Task {
//            await viewModel.load()
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
//    func test_FetchAppInfoUse가_Error를_반환할_때_ViewModelErrorString을_가지고있다() async {
//        // given
//        let fetchAppInfoUseCaseMock = FetchAppInfoUseCaseMock()
//        fetchAppInfoUseCaseMock.error = FetchAppInfoUseError.someError
//
//        let expectation = self.expectation(
//            description: "DefaultAppDetailViewModel은 에러를 가지고 있다.")
//
//        // when
//        let viewModel = DefaultAppDetailViewModel(
//            appId: 1,
//            fetchAppInfoUseCase: fetchAppInfoUseCaseMock)
//
//        // then
//        Task {
//            await viewModel.load()
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
