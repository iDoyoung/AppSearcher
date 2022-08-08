//
//  AppDetailViewControllerTests.swift
//  AppSearcherTests
//
//  Created by Doyoung on 2022/08/08.
//

import XCTest
@testable import AppSearcher

class AppDetailViewControllerTests: XCTestCase {
    //MARK: - System under test
    var sut: AppDetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppDetailViewController()
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test doubles
    class AppDetailBussinessLogicSpy: AppDetailBussinessLogic {
        var getSearchedAppCalled = false
        
        func getSearchedApp() {
            getSearchedAppCalled = true
        }
    }
    //MARK: - Tests
    func test_viewDidLoad_shouldCallGetSearchedAppInInteractor() {
        //given
        let appDetailbussinessLogicSpy = AppDetailBussinessLogicSpy()
        sut.interactor = appDetailbussinessLogicSpy
        //when
        sut.viewDidLoad()
        //then
        XCTAssert(appDetailbussinessLogicSpy.getSearchedAppCalled)
    }
}
