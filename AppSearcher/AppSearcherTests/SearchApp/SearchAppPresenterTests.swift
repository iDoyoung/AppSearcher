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
        sut = SearchAppPresenter()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        searchAppDisplayLogicSpy = nil
    }
    //MARK: - Test doubles
    class SearchAppDisplayLogicSpy: SearchAppDisplayLogic {
        var displaySuccessSearchingCalled = false
        var displayFailedSearchingCalled = false
        var displayUnexpectedNetworkErrorCalled = false
        
        func displaySuccessSearching() {
            displaySuccessSearchingCalled = true
        }
        func displayFailedSearching() {
            displayFailedSearchingCalled = true
        }
        func displayUnexpectedNetworkError() {
            displayUnexpectedNetworkErrorCalled = true
        }
    }
    //MARK: - Tests
    func test_presentFindSearchedApp_shouldBeCallDisplaySuccessSearchingInSearchAppDisplay() {
        //given
        sut.viewController = searchAppDisplayLogicSpy

        //when
        sut.presentFindSearchedApp()
        //then
        XCTAssert(searchAppDisplayLogicSpy.displaySuccessSearchingCalled)
    }
    func test_presentFailedSearchedApp_shouldBeCallDisplayFailedSearching() {
        //given
        sut.viewController = searchAppDisplayLogicSpy
        //when
        sut.presentFailedSearchedApp()
        //then
        XCTAssert(searchAppDisplayLogicSpy.displayFailedSearchingCalled)
    }
    func test_presentUnexpectedNetworkError_shouldBeCallDisplayUnexpectedNetworkError() {
        //given
        sut.viewController = searchAppDisplayLogicSpy
        //when
        sut.presentUnexpectedNetworkError()
        //then
        XCTAssert(searchAppDisplayLogicSpy.displayUnexpectedNetworkErrorCalled)
    }
}
