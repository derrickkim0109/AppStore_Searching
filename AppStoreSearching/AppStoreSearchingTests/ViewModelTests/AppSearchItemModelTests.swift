//
//  AppSearchItemModelTests.swift
//  AppStoreSearchingTests
//
//  Created by Derrick kim on 2023/09/15.
//

import XCTest
@testable import AppStoreSearching

final class AppSearchItemModelTests: XCTestCase {
    var model: AppSearchItemModel!

    override func setUpWithError() throws {
        super.setUp()
        model = AppSearchModelObjectMother.getAppSearchItemModelWithCompleteData()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        model = nil
    }

    func test_iPhone스크린샷의_개수가_3개_이상일_경우_isVisibleScreenShots_True이다() {
        // given
        let expectation = true

        // when
        let isVisibleScreenShots = model.isVisibleScreenShots

        // then
        XCTAssertEqual(isVisibleScreenShots, expectation)
    }
}
