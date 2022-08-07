//
//  AppDetailPresenterTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/07.
//

import XCTest
@testable import AppSearcher

class AppDetailPresenterTests: XCTestCase {
    //MARK: - System under test
    var sut: AppDetailPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppDetailPresenter()
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test doubles
    class AppDetailDisplayLogicSpy: AppDetailDisplayLogicProtocol {
        var displaySerchedAppCalled = false
        
        func displaySearchedApp() {
            displaySerchedAppCalled = true
        }
    }
    //MARK: - Tests
    func test_() {
        //given
        let appDetailDisplayLogicSpy = AppDetailDisplayLogicSpy()
        sut.viewController = appDetailDisplayLogicSpy
        //when
        sut.presentSearched(Seeds.SearchedAppDummy.app)
        //then
        XCTAssert(appDetailDisplayLogicSpy.displaySerchedAppCalled)
    }
}
