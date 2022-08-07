//
//  AppDetailInteractorTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/07.
//

import XCTest
@testable import AppSearcher

class AppDetailInteractorTests: XCTestCase {
    //MARK: - System under test
    var sut: AppDetailInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppDetailInteractor()
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    //MARK: - Test doubles
    class AppDetailPresenterSpy: AppDetailPresentationLogic {
        var presentSearchedCalled = false
        
        func presentSearched(_ app: SearchedApp.Response) {
            presentSearchedCalled = true
        }
    }
    //MARK: - Tests
    func test_getSearchedApp_shouldBeCallPresentSearchedInPresenter() {
        //given
        let appDetailPresenterSpy = AppDetailPresenterSpy()
        sut.presenter = appDetailPresenterSpy
        sut.searchedApp = Seeds.SearchedAppDummy.app
        //when
        sut.getSearchedApp()
        //then
        XCTAssert(appDetailPresenterSpy.presentSearchedCalled)
    }
}
