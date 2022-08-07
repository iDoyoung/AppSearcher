//
//  SearchAppPresenterTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/06.
//

import XCTest
@testable import AppSearcher

class SearchAppPresenterTests: XCTestCase {
    //MARK: - Sytem under test
    var sut: SearchAppPresenter!
    var searchAppDisplayLogicSpy: SearchAppDisplayLogicSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        searchAppDisplayLogicSpy = SearchAppDisplayLogicSpy()
        sut = SearchAppPresenter(searchAppDisplayLogicSpy)
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        searchAppDisplayLogicSpy = nil
    }
    //MARK: - Test doubles
    class SearchAppDisplayLogicSpy: SearchAppDisplayLogic {
        var displaySuccessSearchingCalled = false
        
        func displaySuccessSearching() {
            displaySuccessSearchingCalled = true
        }
    }
    //MARK: - Tests
    func test_presentFindSearchedApp_shouldBeCallDisplaySuccessSearchingInSearchAppDisplay() {
        //given
        //when
        sut.presentFindSearchedApp()
        //then
        XCTAssert(searchAppDisplayLogicSpy.displaySuccessSearchingCalled)
    }
}
